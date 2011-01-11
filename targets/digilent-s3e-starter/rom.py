import sys
import string

addr = 0

for x in sys.stdin.readlines():
  t = string.split(x)
  t = t[1:]
  for byte in t:
    print "      13'd%d: x = 8'h%s;" % (addr,byte)
    addr = addr + 1
