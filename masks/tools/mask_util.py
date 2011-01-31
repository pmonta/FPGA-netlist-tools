from scipy import *

def extract_box(img,y):
  height,width = img.shape
  while y<height:
    if img[y].min()==0:
      break
    y = y + 1
  if y==height:
    return None
  x = img[y].argmin()
  x2 = x + 1
  while x2<width and img[y][x2]==0:
    x2 = x2 + 1
  y2 = y + 1
  while y2<height and (img[y2,x:x2]==img[y,x:x2]).all():
    y2 = y2 + 1
  img[y:y2,x:x2] = 255
  return (x,y,x2,y2)
