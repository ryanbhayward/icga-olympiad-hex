import sys

print('/DimX 11 def')
print('/DimY 11 def')
print('/Scale 1.2 def')
print('FlatTopBoard')
print('DrawHexBoard')
print('1 HexBoardBorders')
print('AltHexBoardCoordinates')

for line in sys.stdin:
  if line[:3]=='#11': 
    move = line.split()[1]
    col = 1+ord(move[0])-ord('a')
    row = int(move[1:])
    print(row, col, 'HexBlackMarker')
