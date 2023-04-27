# -*- coding: utf-8 -*-
import struct
import sys

data = ""
dataout=""
with open(sys.argv[1], 'rb') as f:
	data = f.read()
f.closed

pv=struct.unpack('<I', data[36:40])[0]
otid=struct.unpack('<I', data[40:44])[0]
mask1=65280
mask2=255
mask=255
key4 = (pv ^ otid) >> 24
key3 = ((pv ^ otid) >> 16) & mask
key2 = ((pv ^ otid) >> 8) & mask
key1 = (pv ^ otid) & mask

substructG=[struct.unpack('<B', data[68])[0]]
substructA=[struct.unpack('<B', data[80])[0]]
substructE=[struct.unpack('<B', data[92])[0]]
substructM=[struct.unpack('<B', data[104])[0]]
for i in range(1,12):
	substructG.append(struct.unpack('<B', data[68+i])[0])
	substructA.append(struct.unpack('<B', data[80+i])[0])
	substructE.append(struct.unpack('<B', data[92+i])[0])
	substructM.append(struct.unpack('<B', data[104+i])[0])


checksum=0
i=68
while i < 116:
	checksum=checksum+struct.unpack('<H', data[i:i+2])[0]
	i+=2

data = data[0:64] + struct.pack('<B', checksum & mask2) + struct.pack('<B', (checksum & mask1) >> 8) + data[66:]

i=0
while i < 12:
	substructG[i] ^= key1
	substructA[i] ^= key1
	substructE[i] ^= key1
	substructM[i] ^= key1
	substructG[i+1] ^= key2
	substructA[i+1] ^= key2
	substructE[i+1] ^= key2
	substructM[i+1] ^= key2
	substructG[i+2] ^= key3
	substructA[i+2] ^= key3
	substructE[i+2] ^= key3
	substructM[i+2] ^= key3
	substructG[i+3] ^= key4
	substructA[i+3] ^= key4
	substructE[i+3] ^= key4
	substructM[i+3] ^= key4
	i+=4


mod = pv % 24
i=0
if mod == 0:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 1:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 2:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 3:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
elif mod == 4:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 5:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructG[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
elif mod == 6:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 7:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 8:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 9:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]
elif mod == 10:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 11:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructA[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]
elif mod == 12:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 13:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
elif mod == 14:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructM[i]) + data[105+i:]
elif mod == 15:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructM[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]
elif mod == 16:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
elif mod == 17:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructE[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructM[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]
elif mod == 18:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 19:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructG[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
elif mod == 20:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructE[i]) + data[105+i:]
elif mod == 21:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructA[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructE[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]
elif mod == 22:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructG[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructA[i]) + data[105+i:]
else:
	for i in range(12):
		data = data[0:68+i] + struct.pack('<B', substructM[i]) + data[69+i:]
		data = data[0:80+i] + struct.pack('<B', substructE[i]) + data[81+i:]
		data = data[0:92+i] + struct.pack('<B', substructA[i]) + data[93+i:]
		data = data[0:104+i] + struct.pack('<B', substructG[i]) + data[105+i:]


out = open(sys.argv[2], 'w')
out.write(data)