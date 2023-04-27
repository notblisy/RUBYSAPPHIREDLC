asmProblemBytes = ['\x00', '\x09', '\x0A', '\x22']
def asmQuote(t):
	result = ""
	quoted = False
	if t[0] in asmProblemBytes:
		result = '{0}'.format(ord(t[0]))
	else:
		result = '"' + t[0]
		quoted = True
	t = t[1:]

	while len(t):
		if quoted and t[0] in asmProblemBytes:
			result += '",{0}'.format(ord(t[0]))
			quoted = False
		elif quoted:
			result += t[0]
		elif t[0] in asmProblemBytes:
			result += ',{0}'.format(ord(t[0]))
			quoted = False
		else:
			result += ',"' + t[0]
			quoted = True
		t = t[1:]
	if quoted:
		result += '"'
	return result