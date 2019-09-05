#! /bin/bash

# $1 : The FST file for Q [Q.fst]
# $2 : [Optional] flag for reverse naming

cd ./create-dict-files
FST="../fst-files/${1}"

# create the required fst spec file
fstprint $FST ../text-files/temp
python3 create-prefix-dict.py temp none
rm ../text-files/temp

# get the input and output symbol files for Q
in_table="$(fstinfo ../fst-files/Q.fst | head -n 3 | tail -n 1 | rev | cut -d' ' -f1 | rev)"
out_table="$(fstinfo ../fst-files/Q.fst | head -n 4 | tail -n 1 | rev | cut -d' ' -f1 | rev)"

# compile the required fst file
fstcompile --isymbols="$in_table" --osymbols="$out_table" --keep_isymbols --keep_osymbols ../lex-files/prefix-fst.txt binary.fst

# determinize and minimize the obtained fst
fstdeterminize binary.fst binary.fst
fstminimize binary.fst binary.fst

# cat the created binary so that it can be piped to reqd file and remove the redundant file
cat binary.fst
rm binary.fst