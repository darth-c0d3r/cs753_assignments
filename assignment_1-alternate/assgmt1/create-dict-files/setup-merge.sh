#! /bin/bash

# $1 : file containing words->pronunciation matchings [lex.txt]
# $2 : target directory [fstdir] // not yet done

# The aim is to build 2 FSTs, QPrefix and QSuffix.
# QPrefix was already created in P3.3
# So, only QSuffix is required.

cd ./create-dict-files
LEX="../text-files/${1}"

# STEP 1 : CREATE A SPEC FILE FOR REVERSE WORDS AND PRONUNCIATIONS
python3 create-rev.py $LEX "rev_${1}"

# STEP 2 : USE THE EXISTING create-dict.py code to generate dictionary
FILE=$1
python3 create-dict.py "rev_${1}" rev

# STEP 3 : USE THE CREATED SPEC FILES TO GENERATE LSuffix.fst
fstcompile --isymbols=../lex-files/in_rev.txt --osymbols=../lex-files/out_rev.txt --keep_isymbols --keep_osymbols ../lex-files/fst_rev.txt LSuffix.fst

# STEP 4 : USE THE EXISTING create-let-dict.py code to generate dictionary
python3 create-let-dict.py "../text-files/rev_${FILE}" rev
fstcompile --isymbols=../lex-files/let-in_rev.txt --osymbols=../lex-files/let-out_rev.txt --keep_isymbols --keep_osymbols ../lex-files/let-fst_rev.txt binary.fst

# STEP 5 : invert that file to get spellings->word mapping
fstinvert binary.fst binary.fst

# STEP 6 : compose 2 fst files (spellings->word->pronunciation)
fstcompose binary.fst LSuffix.fst binary.fst
fstdeterminize binary.fst binary.fst
fstminimize binary.fst binary.fst

# move the binary file to QReverse.fst
mv binary.fst QReverse.fst
rm LSuffix.fst # no longer needed

# We need to turn QReverse to QSuffix now

# create the required fst spec file
fstprint QReverse.fst ../text-files/temp
python3 create-prefix-dict.py temp rev
rm ../text-files/temp

# get the input and output symbol files for Q
in_table="$(fstinfo QReverse.fst | head -n 3 | tail -n 1 | rev | cut -d' ' -f1 | rev)"
out_table="$(fstinfo QReverse.fst | head -n 4 | tail -n 1 | rev | cut -d' ' -f1 | rev)"

# compile the required fst file
fstcompile --isymbols="$in_table" --osymbols="$out_table" --keep_isymbols --keep_osymbols ../lex-files/prefix-fst_rev.txt binary.fst

# determinize and minimize the obtained fst
fstdeterminize binary.fst binary.fst
fstminimize binary.fst binary.fst

# cat the created binary so that it can be piped to reqd file and remove the redundant file
mv binary.fst ../fst-files/QSuffix.fst
rm QReverse.fst