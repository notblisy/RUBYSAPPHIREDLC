# -*- coding: utf-8 -*-
import sys

out = open(sys.argv[2], 'w')
buffering = False
buf = ""
with open(sys.argv[1], 'rb') as f:
	f.read(256) # skip to $0100
	while True:
		byte = f.read(1)
		if not byte:
			break

		# the program shall end with $FF followed only by $00 bytes
		# for every $FF we hit, buffer until something that isn’t $00
		if (not buffering and ord(byte) == 0xFF) or (buffering and ord(byte) == 0x00):
			buf += byte
			buffering = True
		elif buffering and ord(byte) == 0xFF:
			out.write(buf)
			buf = byte
		elif buffering:
			out.write(buf)
			out.write(byte)
			buf = ""
			buffering = False
		else:
			out.write(byte)
f.closed