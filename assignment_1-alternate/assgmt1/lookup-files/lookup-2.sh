#! /bin/bash

# Not required for submission. Just to test part 2.

# $1 : fst file [Q.fst]
# $2 : input symbol table [let-out.txt]
# $3 : the spellings (in quotes) ["A L I C E"]

cd ./lookup-files/
FST="../fst-files/${1}"
SYM="../lex-files/${2}"

# create the fst file for the spellings acceptor A
NUM=0
for W in $3
do
	echo "$NUM" $(($NUM+1)) "$W" "$W" >> temp_fst.txt
	NUM=$(($NUM+1))
done
echo "$NUM" >> temp_fst.txt

# create a new fst file for acceptor
fstcompile --isymbols=$SYM --osymbols=$SYM --keep_isymbols --keep_osymbols temp_fst.txt acceptor.fst

# remove the temporary files
rm temp_fst.txt

# sort the FSTs before composing
fstarcsort --sort_type=olabel acceptor.fst acceptor.fst
fstarcsort --sort_type=ilabel $FST binary.fst

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
