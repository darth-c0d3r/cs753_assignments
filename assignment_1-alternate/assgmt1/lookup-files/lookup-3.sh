#! /bin/bash

# Can be used for testing part 2 as well

# $1 : fst file [QPrefix.fst] [QSuffix.fst]
# $2 : input symbol table [let-out.txt] [let-out_rev.txt]
# $3 : the required word [ALICE] [ECILA]

cd ./lookup-files
FST="../fst-files/${1}"
SYM="../lex-files/${2}"

# create the fst file for the spellings acceptor A
NUM=0
WORD=$3
ARRAY=()
for (( i=0; i<${#WORD}; i++ )); do
	W="${WORD:$i:1}"
	ARRAY+=("$W")
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
# fstrmepsilon binary.fst binary.fst
# fstpush --push_labels binary.fst binary.fst
fstprint binary.fst fstfile.txt

# call the python file to parse and print
# CONVERT $3 TO AN ARRAY AND FORWARD // sad fix
python3 printfst.py fstfile.txt "${ARRAY[@]}"

# remove all the extra files
rm fstfile.txt
rm acceptor.fst
rm binary.fst
