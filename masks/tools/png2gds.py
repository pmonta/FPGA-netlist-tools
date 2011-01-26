#!/usr/bin/python

import sys
import scipy
import readmagick
import gdspy
from mask_util import *

def stripe(c,gds_layer,x,y):
  for (z,k) in rle(x):
    c.add(gdspy.Rectangle(gds_layer, (z,y), (z+k,y+1)))

def layer(c,file,gds_layer):
  try:
    img = readmagick.readimg(file)
  except:
    return
  height,width,bytes = img.shape
  for y in xrange(0,height):
    stripe(c,gds_layer,img[y,:,0],height-y-1)

# parse command-line arguments

name = sys.argv[1]
scale = sys.argv[2]

# GDS initialization

c = gdspy.Cell(name)

# GDS layers

layer(c,"diffusion.png",1)
layer(c,"implant.png",2)
layer(c,"buried.png",3)
layer(c,"poly.png",4)
layer(c,"contact.png",5)
layer(c,"metal.png",6)
layer(c,"overglass.png",7)

# GDS finalize

import sys
gdspy.gds_print(sys.stdout, unit=float('%se-6'%scale), precision=1.0e-9)
