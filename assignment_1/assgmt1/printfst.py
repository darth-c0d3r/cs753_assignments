import sys

# PROBABLY NEED TO IMPROVE
# BY IMPLEMENTING BFS

# get the filename to be parsed
filename = sys.argv[1]
input_words = sys.argv[2:]

# read all the lines
all_lines = open(filename, 'r').readlines()

# make a dictionary for the WFST
graph = {}
final_state = 0
for line in all_lines:
	line_ = line.strip().split("\t")

	# set final state
	if len(line_) == 1:
		final_state = int(line_[0])
		continue

	# add the arc
	if int(line_[0]) not in graph:
		graph[int(line_[0])] = {}
	graph[int(line_[0])][line_[2]] = (int(line_[1]), line_[3])

# now traverse the graph using the dict

# current state for traversal
curr_state = 0
output_word = ""

# traverse over all input words
for word in input_words:

	if curr_state not in graph:
		output_word = "<OOV>"
		break

	# if the word is not on any arc
	# look to match epsilon
	if word not in graph[curr_state]:

		# if epsilon is also not on any arc
		# the traversal has failed
		if "<eps>" not in graph[curr_state]:
			output_word = "<OOV>"
			break
		else:
			if graph[curr_state]["<eps>"][1] != "<eps>":
				output_word += graph[curr_state]["<eps>"][1] + " "
			curr_state = graph[curr_state]["<eps>"][0]
	else:
		if graph[curr_state][word][1] != "<eps>":
			output_word += graph[curr_state][word][1] + " "
		curr_state = graph[curr_state][word][0]

# try to match with epsilon until reaching final_state
while curr_state != final_state:
	if "<eps>" not in graph[curr_state]:
		output_word = "<OOV>"
		break
	else:
		if graph[curr_state]["<eps>"][1] != "<eps>":
			output_word += graph[curr_state]["<eps>"][1] + " "
		curr_state = graph[curr_state]["<eps>"][0]

print(output_word)