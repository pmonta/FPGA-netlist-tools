#!/usr/bin/python

import sys
import scipy
import readmagick
import gdspy
from mask_util import *

def layer(c,file,gds_layer):
  try:
    img = readmagick.readimg(file)
  except:
    return
  img = img[:,:,0]
  height,width = img.shape
  y = 0
  while True:
    box = extract_box(img,y)
    if not box:
      break
    (x,y,x2,y2) = box
    c.add(gdspy.Rectangle(gds_layer, (x,height-y), (x2,height-y2)))

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
