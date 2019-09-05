import sys
import os

# take the input lex filename
filename = "../text-files/"+sys.argv[1]

# the files which contain the info to build fst
file_in  = "in.txt"
file_out = "out.txt"
file_fst = "fst.txt"

# a quick fix to reuse the same code for part 3
if len(sys.argv) > 2:
	file_in  = "in_"+sys.argv[2]+".txt"
	file_out = "out_"+sys.argv[2]+".txt"
	file_fst = "fst_"+sys.argv[2]+".txt"	

# read all the words
all_words = open(filename, 'r').readlines()

# initialize counters
curr_state = 1
curr_in = 1
curr_out = 1

# initialize output dictionary, input tuple and fst file
dict_out = {}
tuple_in = []
fst_out = []

# initialize for epsilon
dict_out["<eps>"] = 0
tuple_in.append(("<eps>", 0))

# iterate over all words
for word in all_words:

	# split the input line
	word_, lexemes = word.strip().split("\t")

	# append word to input tuple
	tuple_in.append((word_, curr_in))
	curr_in += 1

	curr_temp = 0
	curr_word = word_

	# iterate over all lexemes
	for lex in lexemes.split(" "):

		# add to output dict if not already done
		if lex not in dict_out:
			dict_out[lex] = curr_out
			curr_out += 1

		# append the output to be written
		fst_out.append("%d %d %s %s"%(curr_temp, curr_state, curr_word, lex))
		curr_temp = curr_state
		curr_state += 1
		curr_word = "<eps>"

	# handle the case for kleene-closure
	fst_out.append("%d %d %s %s"%(curr_state-1, 0, "<eps>", "<eps>"))

# add the final state to the fst file
fst_out.append("0") # weight can be arbitrary

# write values to all the files

if "lex-files" not in os.listdir("../"):
	os.mkdir("../lex-files")

# input symbols file
with open("../lex-files/"+file_in, 'w+') as file:
	for line in tuple_in:
		file.write(line[0] + " " + str(line[1])+"\n")

# output symbols file
with open("../lex-files/"+file_out, 'w+') as file:
	for word in dict_out:
		file.write("%s %d\n"%(word, dict_out[word]))

# fst file
with open("../lex-files/"+file_fst, 'w+') as file:
	for line in fst_out:
		file.write(line+"\n")
