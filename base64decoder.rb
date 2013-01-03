s = "SGVsbG8hIFRoaXMgaXMgYSB0ZXN0IG91dHB1dCE="
b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
i = 0
base64 = []
base64blocks = []

#Store the decimal base64 values into the base64 array
for i in 0...s.length
	if s[i] == "="
		base64[i] = 0 
	else
		base64[i] = b64.index(s[i])
	end
end

#create blocks of 4 base64 numbers
i = 4
0.step((base64.length-1), 4) do |x|
	base64blocks << base64[x...i]
	i += 4
end

#raw 24 bit representations are stored in the rawDecodedBase64
rawDecodedBase64 = []
base64blocks.each do |block|
	if ((block[2] == 0) and (block[3] == 0))
		rawDecodedBase64 << ((block[0] << 18) | (block[1] << 12) | 0 | 0)
	elsif (block[3] == 0)
		rawDecodedBase64 << ((block[0] << 18) | (block[1] << 12) | (block[2] << 6) | 0)
	else
		rawDecodedBase64 << ((block[0] << 18) | (block[1] << 12) | (block[2] << 6) | block[3])
	end
end

#This contains the decoded ASCII values of the string
decodedBase64 = []
rawDecodedBase64.each do |x|
	decodedBase64 << ((x & (255 << 16)) >> 16)
	decodedBase64 << ((x & (255 << 8)) >> 8)
	decodedBase64 << (x & 255)
end

print "Input string: ",s,"\n"
puts "The ASCII value of the base64 input string is"
#Prints the ASCII string
decodedBase64.each do |x|
	print x.chr
end
puts 
__END__
This uses the output of "base64conversion.rb"

Program Output:
Input string: SGVsbG8hIFRoaXMgaXMgYSB0ZXN0IG91dHB1dCE=
The ASCII value of the base64 input string is
Hello! This is a test output!