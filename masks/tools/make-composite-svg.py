#!/usr/bin/python

import sys
import re

def print_svg_header(X,Y):
  s = """<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"
 "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg version="1.0" xmlns="http://www.w3.org/2000/svg"
 width="%dpt" height="%dpt" viewBox="0 0 %d %d"
 preserveAspectRatio="xMidYMid meet">
<metadata>
Created by potrace 1.9, written by Peter Selinger 2001-2010
</metadata>""" % (X,Y,X,Y)
  sys.stdout.write(s)

def print_svg_footer():
  s = "</svg>"
  sys.stdout.write(s)

def read_svg_group(filename):
  try:
    f = open(filename,"r")
  except:
    return None
  s = f.read()
  f.close()
  m = re.search(r'<g.*?>(.*?)</g>',s,re.DOTALL);
  return m.group(1)

#
# main program
#

X = int(sys.argv[1])
Y = int(sys.argv[2])

print_svg_header(X,Y)

props = { "diffusion":("0.5","#80ff80","Diff"),
          "buried":("0.5","#c0c0c0","Buried"),
          "poly":("0.5","#ff8080","Poly"),
          "contact":("0.75","#404040","Contacts"),
          "metal":("0.5","#8080ff","Metal") }

for i in ["diffusion","buried","poly","contact","metal"]:
  opacity,color,svg_name = props[i]
  s = read_svg_group(i+".vec.svg")
  if s:
    sys.stdout.write('<g id="%s" style="opacity:%s;fill:%s">' % (svg_name,opacity,color))
    sys.stdout.write(s)
    sys.stdout.write('</g>')

print_svg_footer()
