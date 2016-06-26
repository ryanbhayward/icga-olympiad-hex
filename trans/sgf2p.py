#!/usr/local/bin/python
import sys
maxmoves = 10 # print only this many
moves = 0
for line in sys.stdin:
  content = line.split('[')
  for x in content:
    if x[0].isalpha() and x[1].isdigit(): 
      moves += 1
      if x[2].isdigit(): print x[:3],
      else:              print ' ' + x[:2], 
      if moves == maxmoves: break
    if moves == maxmoves: break
  if moves == maxmoves: break
print ''
