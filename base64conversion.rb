# Ashwin Saval
# The output of this program is an unmapped output
# to get actual values, a hash table needs to be built with base64 mappings

# Returns an array that contains blocks of the string of 3bytes each
def createBlocks(aString)
	i = 0
	arrOfBlocks = []
	while  i < aString.length
		arrOfBlocks << aString[i..(i+2)]
		i = i + 3
	end
	return arrOfBlocks
end

# Accepts a 24bit input and outputs a base64 array
def base64(block24bit)
	base64 = Array.new(4) #stores the base64 values
	comparator = 63 << 18 # 00111111 shifted to 18 places
	0.upto(3) do |i|
		base64[i] = (block24bit & comparator)
		shifter = 6 * (3 - i)
		base64[i] = (base64[i] >> shifter)
		comparator = comparator >> 6
	end
	return base64
end


# returns an array with values of a base64 string
def base64Encoder(aString)
	bytes3Blocks = createBlocks(aString)
	base64array = []
	override = 0
	bytes3Blocks.each do |block|
		if block.length == 3
			block24bit = ((block[0].ord << 16) | (block[1].ord << 8) | block[2].ord)
		elsif block.length == 1
			override = 2
			block24bit = ((block[0].ord << 16) | (0 << 8) | 0)
		else
			override = 1
			block24bit = ((block[0].ord << 16) | (block[1].ord << 8) | 0)
		end
		
		encodedVal = base64(block24bit)
		# Override conditions
		encodedVal[3], encodedVal[2] = "=", "=" if (override == 2)
		encodedVal[3] = "=" if (override == 1)
		base64array << encodedVal
	end
	return base64array
end

s = String.new("ABCde GHITestINGThisOutpu")
b64 = "ABCDEFGHIJKLMNOPQRSSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
base64string = base64Encoder(s)
print "The original string: "
puts s
print "The blocks are: "
createBlocks(s).each {|x| print x," "}
puts
puts "The base64 string is"
base64string.each do |x|
	x.each do |y|
		print "=" if y == "="
		print b64[y]
	end
	print " "
end
puts

__END__

# This is the output of the above program
The original string: ABCde GHITestINGThisOutpu
The blocks are: ABC de  GHI Tes tIN GTh isO utp u 
The base64 string is
QTJD YGTf RzgJ UGUy cEkO R0Rn ZWNP cWRv cQ==