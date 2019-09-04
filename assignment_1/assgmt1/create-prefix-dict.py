import sys
from shutil import copyfile

# get the fst specification filename
filename = sys.argv[1]

all_lines = open(filename, 'r').readlines()

with open('lex-files/prefix-fst.txt', 'w+') as file:

	for line in all_lines:

		line_ = line.strip().split("\t")
		file.write(" ".join(line_)+"\n")

		if len(line_) != 1 and int(line_[1]) != 0:
			file.write(" ".join([line_[1], "0", "<eps>", "<eps>"])+"\n")
