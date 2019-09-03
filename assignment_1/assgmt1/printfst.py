import sys

# PROBABLY NEED TO IMPROVE
# BY IMPLEMENTING TRAVERSAL

# get the filename to be parsed
filename = sys.argv[1]

# read all the lines
all_lines = open(filename, 'r').readlines()

# iterate over all lines and get the required string
final_ans = ""
for line in all_lines:
	print(line.strip())

	# if it is just a final state
	if len(line.strip().split("\t")) == 1:
		continue

	# get the output word
	word = line.strip().split("\t")[-1]
	if word != "<eps>":
		final_ans += word + " "

# print the required word
if len(all_lines) == 0:
	print("<OOV>")
else:
	print(final_ans.strip())
