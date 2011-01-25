#!/usr/bin/python

import scipy
import readmagick
import gdspy

def rle(x):
  r = []
  i = 0
  state = 0
  while 1:
    if i==len(x):
      break
    if state:
      if x[i]!=255:
        k = k + 1
      else:
        r.append((z,k))
        state = 0
      i = i + 1
    else:
      if x[i]!=255:
        z = i
        k = 1
        state = 1
      i = i + 1
  if state:
    r.append((z,k))
  return r

def stripe(c,gds_layer,x,y):
  for (z,k) in rle(x):
    c.add(gdspy.Rectangle(gds_layer, (z,y), (z+k,y+1)))

def layer(c,file,gds_layer):
  img = readmagick.readimg(file)
  height,width,bytes = img.shape
  for y in xrange(0,height):
    stripe(c,gds_layer,img[y,:,0],height-y-1)

# GDS initialization

c = gdspy.Cell('6502')

# GDS layers

layer(c,"diffusion.png",1)
#layer(c,"implant.png",2)
layer(c,"buried.png",3)
layer(c,"poly.png",4)
layer(c,"contact.png",5)
layer(c,"metal.png",6)
#layer(c,"overglass.png",7)

# GDS finalize

import sys
gdspy.gds_print(sys.stdout, unit=1.2e-6, precision=1.0e-9)
