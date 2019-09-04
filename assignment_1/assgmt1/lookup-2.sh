#! /bin/bash

# This file is not required in the submission
# Just making it for testing part 2

# $1 : fst file
# $2 : input symbol table
# $3 : the spellings (in quotes)

# create the fst file for the spellings acceptor A
NUM=0
for W in $3
do
	echo "$NUM" $(($NUM+1)) "$W" "$W" >> temp_fst.txt
	NUM=$(($NUM+1))
done
echo "$NUM" >> temp_fst.txt

# create a new fst file for acceptor
fstcompile --isymbols=$2 --osymbols=$2 --keep_isymbols --keep_osymbols temp_fst.txt acceptor.fst

# remove the temporary files
rm temp_fst.txt

# sort the FSTs before composing
fstarcsort --sort_type=olabel acceptor.fst acceptor.fst
fstarcsort --sort_type=ilabel $1 binary.fst

# take composition of the 2 binary fst files
# take the output into the original binary
fstcompose acceptor.fst binary.fst binary.fst
fstdeterminize binary.fst binary.fst
fstminimize binary.fst binary.fst
fstprint binary.fst fstfile.txt

# call the python file to parse and print
python3 printfst.py fstfile.txt $3

# remove all the extra files
rm fstfile.txt
rm acceptor.fst
rm binary.fst
