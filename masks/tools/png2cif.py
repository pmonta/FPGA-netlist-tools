#!/usr/bin/python

import sys
import scipy
import readmagick
from mask_util import *

def layer(file,cif_name):
  try:
    img = readmagick.readimg(file)
  except:
    return
  print 'L '+cif_name+';'
  img = img[:,:,0]
  width,height = img.shape
  y = 0
  while True:
    box = extract_box(img,y)
    if not box:
      break
    (x,y,x2,y2) = box
    print ' B %d %d %d %d;' % (2*(x2-x),2*(y2-y),x+x2,y+y2)

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

# CIF footer

print "DF;"
print "C 1;"
print "E"
