import sys
from shutil import copyfile

# get the fst specification filename
filename = sys.argv[1]
file_out = 'lex-files/prefix-fst.txt'

# quick fix to make the code work for P3.4
if len(sys.argv) > 2:
	file_out = 'lex-files/prefix-fst_' + sys.argv[2] + '.txt'

all_lines = open(filename, 'r').readlines()

with open(file_out, 'w+') as file:

	for line in all_lines:

		line_ = line.strip().split("\t")
		file.write(" ".join(line_)+"\n")

		if len(line_) != 1 and int(line_[1]) != 0:
			file.write(" ".join([line_[1], "0", "<eps>", "<eps>"])+"\n")
