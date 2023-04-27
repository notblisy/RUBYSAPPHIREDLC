import struct
import sys

chunk_lengths = [0,0,0,6,2,5,12,5,3,1,2,5,5,5,1,13,13]

bytewises = []
bytewise_results = []
wordwises = []
wordwise_results = []
crcs = []
crc_results = []

data = ""
with open(sys.argv[1], 'rb') as f:
	data = f.read()
f.closed

base_address = struct.unpack('<I', data[1:5])[0]
i = 0x11 # first chunk location
while i < len(data):
	chunk_type = ord(data[i])
	if chunk_type == 0x02: # END_OF_CHUNKS
		break
	elif chunk_type == 0x07: # CUSTOM_BERRY
		start_address = struct.unpack('<I', data[i+1:i+5])[0] - base_address
		bytewises.append([start_address + 0x52C, start_address, start_address + 0x52C])
	elif chunk_type == 0x0D: # BATTLE_TRAINER
		start_address = struct.unpack('<I', data[i+1:i+5])[0] - base_address
		wordwises.append([start_address + 0xB8, start_address, start_address + 0xB8])
	elif chunk_type == 0x0F: # CHECKSUM_BYTES
		start_address = struct.unpack('<I', data[i+5:i+9])[0] - base_address
		end_address = struct.unpack('<I', data[i+9:i+13])[0] - base_address
		bytewise.append([i + 1, start_address, end_address])
	elif chunk_type == 0x10: # CHECKSUM_CRC
		start_address = struct.unpack('<I', data[i+5:i+9])[0] - base_address
		end_address = struct.unpack('<I', data[i+9:i+13])[0] - base_address
		crcs.append([i + 1, start_address, end_address])
	elif chunk_type < 0x02 or chunk_type > 0x10:
		print "Unknown chunk {0:X}".format(chunk_type)
		raise TypeError
	i += chunk_lengths[chunk_type]


# calculate and insert all wordwise checksums
for wordwise in wordwises:
	sum = 0
	for i in range(wordwise[1], wordwise[2], 4):
		sum = (sum + struct.unpack('<I', data[i:i+4])[0]) & 0xFFFFFFFF
	wordwise_results.append(sum)
i = 0
for wordwise in wordwises:
	data = data[0:wordwise[0]] + struct.pack('<I', wordwise_results[i]) + data[(wordwise[0] + 4):]
	i += 1


# calculate and insert all bytewise checksums
for bytewise in bytewises:
	sum = 0
	for i in range(bytewise[1], bytewise[2]):
		sum = (sum + ord(data[i])) & 0xFFFFFFFF
	bytewise_results.append(sum)
i = 0
for bytewise in bytewises:
	data = data[0:bytewise[0]] + struct.pack('<I', bytewise_results[i]) + data[(bytewise[0] + 4):]
	i += 1


# calculate and insert all CRC checksums
for crc in crcs:
	sum = 0x1121
	for i in range(crc[1], crc[2]):
		sum ^= ord(data[i])
		for j in range(8):
			if(sum & 1):
				sum = (sum >> 1) ^ 0x8408
			else:
				sum >>= 1
	sum = ~sum & 0xFFFF
	crc_results.append(sum)

i = 0
for crc in crcs:
	data = data[0:crc[0]] + struct.pack('<I', crc_results[i]) + data[(crc[0] + 4):]
	i += 1


# write the updated file
out = open(sys.argv[2], 'w')
out.write(data)