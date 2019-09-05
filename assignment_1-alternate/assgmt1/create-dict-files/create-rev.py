import sys

# Read words from filename
# Reverse them and their pronunciations
# Write back to file_out

filename = sys.argv[1]
file_out = "../text-files/"+sys.argv[2]

with open(file_out, 'w+') as file:

	# read all lines of input file
	all_lines = open(filename, 'r').readlines()

	# iterate over all lines
	for line in all_lines:

		# reverse the word and it's pronunciation
		word, pronunciation = line.strip().split("\t")
		pronunciation = pronunciation.split(" ")
		pronunciation.reverse()

		# write the required string back into the target file
		file.write(word[::-1] + "\t" + " ".join(pronunciation)+"\n")