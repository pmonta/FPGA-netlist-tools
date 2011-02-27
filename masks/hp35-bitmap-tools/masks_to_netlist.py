#!/usr/bin/python

#
# masks_to_netlist.py pins.txt metal.png diffusion.png contact.png gate.png implant.png >netlist.txt
#
# Convert mask images to a transistor netlist.  Currently specific to PMOS or NMOS metal-gate processes.
#
# Peter Monta
# November 2010
#

import scipy
from scipy import ndimage
import readmagick
import sys
import string

#
# read the list of pins.  Each line is of the form "<pin_name> <x> <y>".
#

pins = {}

f = open(sys.argv[1],"r")
for x in f.readlines():
  l = string.split(x)
  name,x,y = l[0],int(l[1]),int(l[2])
  pins[name] = (x,y)
f.close()

#
# read in the mask bitmaps and label them
#

metal,metal_n = ndimage.label(readmagick.readimg(sys.argv[2]))
diffusion,diffusion_n = ndimage.label(readmagick.readimg(sys.argv[3]))
contact,contact_n = ndimage.label(readmagick.readimg(sys.argv[4]))
gate,gate_n = ndimage.label(readmagick.readimg(sys.argv[5]))
implant,implant_n = ndimage.label(readmagick.readimg(sys.argv[6]))

print '# metal: %d objects' % metal_n
print '# diffusion: %d objects' % diffusion_n
print '# contact: %d objects' % contact_n
print '# gate: %d objects' % gate_n
print '# implant: %d objects' % implant_n

#
# emit "pin" objects that intersect metal or diffusion
#

for p in pins.keys():
  x,y = pins[p]
  node = metal[y][x]
  prefix = 'm'
  if node==0:
    node = diffusion[y][x]
    prefix = 'd'
  print 'p %s %s%d' % (p,prefix,node)

#
# emit "contact" objects by intersecting contact layer with metal and diffusion
#

contacts = {}

for j,c in enumerate(ndimage.find_objects(contact)):
  i = j+1
  contact_mask = contact[c]==i
  metal_objs = set((contact_mask*metal[c]).flat) - set([0])
  diffusion_objs = set((contact_mask*diffusion[c]).flat) - set([0])
  if len(metal_objs)!=1 or len(diffusion_objs)!=1:
    print '# invalid contact %d: intersects metal %s and diffusion %s' % (i,str(metal_objs),str(diffusion_objs))
    continue
  metal_i,diffusion_i = metal_objs.pop(),diffusion_objs.pop()
  contacts[i] = (metal_i,diffusion_i)
  print 'c m%d d%d' % (metal_i,diffusion_i)

#
# emit "transistor" objects by intersecting gate layer with diffusion and implant
#

transistors = {}

for j,c in enumerate(ndimage.find_objects(gate)):
  i = j+1
  gate_mask = gate[c]==i
  metal_objs = set((gate_mask*metal[c]).flat) - set([0])
  if len(metal_objs)!=1:
    print '# invalid gate %d: intersects metal %s' % (i,str(metal_objs))
    continue
  metal_i = metal_objs.pop()
  implant_objs = set((gate_mask*implant[c]).flat)
  if len(implant_objs)!=1:
    print '# invalid gate %d: intersects implant %s' % (i,str(implant_objs))
    continue
  implant_i = implant_objs.pop()
  transistor_type = 'e' if implant_i==0 else 'd'
  diffusion_objs = set((gate_mask*diffusion[c]).flat) - set([0])
  if len(diffusion_objs)==1:
    print '# gate %d has single diffusion (MOS capacitor?)' % i
    continue
  elif len(diffusion_objs)!=2:
    print '# invalid gate %d: intersects diffusion %s' % (i,str(diffusion_objs))
    continue
  gate_i = metal_i
  source_i = diffusion_objs.pop()
  drain_i = diffusion_objs.pop()
  transistors[i] = (gate_i,source_i,drain_i,transistor_type)
  print 't m%d d%d d%d %s' % (gate_i,source_i,drain_i,transistor_type)

#
# print orphans
#

r_metal = set(range(1,metal_n+1))
r_diffusion = set(range(1,diffusion_n+1))
r_contact = set(range(1,contact_n+1))
r_gate = set(range(1,gate_n+1))

for c in contacts.keys():
  r_contact.discard(c)
  metal_i,diffusion_i = contacts[c]
  r_metal.discard(metal_i)
  r_diffusion.discard(diffusion_i)
  
for g in transistors.keys():
  r_gate.discard(g)
  (gate,source,drain,transistor_type) = transistors[g]
  r_metal.discard(gate)
  r_diffusion.discard(source)
  r_diffusion.discard(drain)

print '# metal orphans: ',r_metal
print '# diffusion orphans: ',r_diffusion
print '# contact orphans: ',r_contact
print '# gate orphans: ',r_gate
