#!/usr/bin/python

import sys
import scipy
import readmagick
import string
from mask_util import *

height = 0

def layer(file,cif_name):
  global height
  try:
    img = readmagick.readimg(file)
  except:
    return
  print 'L '+cif_name+';'
  img = img[:,:,0]
  height,width = img.shape
  y = 0
  while True:
    box = extract_box(img,y)
    if not box:
      break
    (x,y,x2,y2) = box
    print ' B %d %d %d %d;' % (2*(x2-x),2*(y2-y),x+x2,2*height-(y+y2))

def node_labels(file):
  try:
    f = open(file,"r")
  except:
    return
  for t in f.readlines():
    r = string.split(t)
    if not r:
      continue
    node = r[0]
    if node[0]==';':
      continue
    x = int(r[1])
    y = int(r[2])
    layer = r[3]
    print '94 %s %d %d %s;' % (node,2*x,2*height-2*y,layer)

# parse command-line arguments

name = sys.argv[1]
scale = sys.argv[2]

# CIF header

print "( CIF conversion of visual6502 polygon data );"
print "DS 1 %d 1;" % round(100*float(scale)/2)
print "9 %s;" % name

# CIF layers (NMOS)

layer("diffusion.png","ND")
layer("implant.png","NI")
layer("buried.png","NB")
layer("poly.png","NP")
layer("contact.png","NC")
layer("metal.png","NM")
layer("overglass.png","NG")

# node labels

node_labels("nodes.txt")
node_labels("pads.txt")

# CIF footer

print "DF;"
print "C 1;"
print "E"
