#! /bin/bash

# $1 : lex file (contains words and their pronunciations) [lex.txt]

cd create-dict-files
python3 create-dict.py $@
fstcompile --isymbols=../lex-files/in.txt --osymbols=../lex-files/out.txt --keep_isymbols --keep_osymbols ../lex-files/fst.txt binary.fst
fstpush --push_labels binary.fst binary.fst
cat binary.fst
rm binary.fst