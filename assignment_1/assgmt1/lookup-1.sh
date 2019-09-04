#! /bin/bash

# $1 : fst file [L.fst]
# $2 : input symbol table [lex-files/in.txt]
# $3 : the word [ALICE]

# first we should check if word exists in input symbol table
# if it doesn't exist, just output the special symbol <OOV>
# checks if there's a line starting with word $3 in file $2
if grep -Gwq $3 $2
then
	# make the temporary file to make a new fst file
	echo "0 1 $3 $3" > temp_fst.txt
	echo "1" >> temp_fst.txt

	# make a new temporary fst file for acceptor
	fstcompile --isymbols=$2 --osymbols=$2 --keep_isymbols --keep_osymbols temp_fst.txt acceptor.fst

	# remove the temporary files
	rm temp_fst.txt

	# sort the FSTs before composing
	fstarcsort --sort_type=olabel acceptor.fst acceptor.fst
	fstarcsort --sort_type=ilabel $1 binary.fst

	# take composition of the 2 binary fst files
	# take the output into the original binary
	fstcompose acceptor.fst binary.fst binary.fst
	fstprint binary.fst fstfile.txt

	# read the newly created file and print the output
	python3 printfst.py fstfile.txt $3

	# remove all the extra files
	rm fstfile.txt
	rm acceptor.fst
	rm binary.fst

else
	# print the default symbol
	echo "<OOV>"
fi