#! /bin/bash

# $1 : lex file (contains words and their pronunciations) [lex.txt]

python3 create-dict.py $1
fstcompile --isymbols=lex-files/in.txt --osymbols=lex-files/out.txt --keep_isymbols --keep_osymbols lex-files/fst.txt binary.fst
cat binary.fst
rm binary.fst