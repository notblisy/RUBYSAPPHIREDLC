# -*- coding: utf-8 -*-
import sys
from asmquote import asmQuote

region = sys.argv[3]

out = open(sys.argv[2], 'w')

with open(sys.argv[1], 'rb') as f:
	for asm in f:
		asms = asm.split('"')
		command = asms[0].strip()
		if command == "db":
			# this is only for the American e-Reader; still need to deal with Japanese
			asms[1] = asms[1].replace('\\0', '\x00')
			asms[1] = asms[1].replace('\\n', '\n')
			asms[1] = asms[1].replace('é', '\x7F')

			out.write("db " + asmQuote(asms[1]) + "\n")
		else:
			out.write(asm)
			if "macros.asm" in asm:
				out.write("REGION EQU REGION_{0}\n".format(region))
				out.write('REGION_NAME EQUS "{0}"\n'.format(region))

f.closed