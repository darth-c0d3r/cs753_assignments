#! /bin/bash

# $1 : lex file (contains words and their pronunciations)
# $2 : the word->pronunciation fst file

python3 create-let-dict.py $1 $2
fstcompile --isymbols=lex-files/let-in.txt --osymbols=lex-files/let-out.txt --keep_isymbols --keep_osymbols lex-files/let-fst.txt binary.fst
fstinvert binary.fst binary.fst
fstcompose binary.fst $2 binary.fst
# fstdeterminize binary.fst binary.fst
# fstminimize binary.st binary.fst
cat binary.fst
rm binary.fst