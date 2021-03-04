#!/usr/local/bin/python3
# convert from 2020 olympiad .txt to .sgf
import sys

boardsize = 19

def getDiagram():
  L = sys.stdin.readlines()
  for k in range(len(L)): L[k] = L[k].strip()
  return L

def printHead(size):
  print("(;AP[HexGui:0.9.GIT]FF[4]GM[11]SZ[" + str(size) + "]")

def parseLines(L):
  movenumber = 1
  for x in L:
    #print(x)
    for j in "().":
      x = x.replace(j,' ')
    words = x.split()
    #print(words)
    assert(int(words[0]) == movenumber)
    color = 'B' if words[-3][-1]=='1' else 'W'
    if (movenumber == 2) and 'swap' in words[1].lower():
      print(';'+color+'[swap-pieces]',end='')
    else:
      move = ';'+color+'['+words[-1].lower()+']'
      if len(move)==6:
        move += ' '
      print(move, end='')
    if 0==(movenumber % 10): 
      print('')
    movenumber += 1
  print(')')

L = getDiagram()
printHead(boardsize)
parseLines(L)

