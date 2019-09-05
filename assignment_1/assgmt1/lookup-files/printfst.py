import sys
import queue

# get the filename to be parsed
filename = sys.argv[1]

# read all the lines
all_lines = open(filename, 'r').readlines()

# make a dictionary for the WFST
graph = {}
final_state = []
for line in all_lines:
	# print(line.strip())
	line_ = line.strip().split("\t")

	# set final state
	if len(line_) == 1:
		final_state.append(int(line_[0]))
		if int(line_[0]) not in graph:
			graph[int(line_[0])] = {}
		continue

	# add the arc
	if int(line_[0]) not in graph:
		graph[int(line_[0])] = {}
	graph[int(line_[0])][line_[2]] = (int(line_[1]), line_[3])

# now traverse the graph using the dict
all_answers = []
q = queue.Queue()
q.put((0, ""))

# repeat till the queue is empty
while not q.empty():
	
	curr_state, curr_word = q.get()
	# print(curr_state, curr_word)

	if curr_state not in graph:
		all_answers.append("<OOV>")
		break

	transition = False
	for action in graph[curr_state]:
		next_state = graph[curr_state][action][0]
		transition = True
		next_word = curr_word
		if graph[curr_state][action][1] != "<eps>":
			next_word += graph[curr_state][action][1] + " "
		q.put((next_state,next_word))

	if transition is False:
		all_answers.append(curr_word)

# choose the maximal answer
best_len = 0
best_word = ""
for ans in all_answers:
	ans_ = ans.strip().split(" ")
	if len(ans_) > best_len:
		best_len = len(ans_)
		best_word = ans
print(best_word)
