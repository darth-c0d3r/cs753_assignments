def WER(X,Y):
	"""
	returns the lavenshtein distance between X and Y
	X and Y are 2 strings of arbitrary lengths,
	represented as arrays.
	"""

	# if any of the string is empty
	# return the length of the other
	if len(X)*len(Y) == 0:
		return max(len(X), len(Y))

	# if zeroth elements are same,
	# no need to make changes
	if X[0] == Y[0]:
		return WER(X[1:], Y[1:])

	if len(X) == len(Y):
		return 1+WER(X[1:], Y[1:])

	if len(X) > len(Y):
		return 1 + min(WER(X[1:], Y[:]), WER(X[1:], Y[1:]))

	if len(X) < len(Y):
		return 1 + min(WER(X[:], Y[1:]), WER(X[1:], Y[1:]))


A = list("abcde")
B = list("be")

print(WER(A, B))
