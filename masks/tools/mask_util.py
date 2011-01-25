from scipy import *
from scipy import ndimage

def rle(x):
  x,n = ndimage.label(array([255])-x)
  r = []
  k = array(xrange(0,len(x)))
  for i in xrange(0,n):
    s = k[x==(i+1)]
    r.append((min(s),len(s)))
  return r
