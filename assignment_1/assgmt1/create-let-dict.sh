#! /bin/bash

# $1 : lex file (contains words and their pronunciations) [lex.txt]
# $2 : the word->pronunciation fst file [L.fst]

# create the word->spellings fst file
python3 create-let-dict.py $1
fstcompile --isymbols=lex-files/let-in.txt --osymbols=lex-files/let-out.txt --keep_isymbols --keep_osymbols lex-files/let-fst.txt binary.fst

# invert that file to get spellings->word mapping
fstinvert binary.fst binary.fst

# compose 2 fst files (spellings->word->pronunciation)
fstcompose binary.fst $2 binary.fst
cat binary.fst > send
fstdeterminize binary.fst binary.fst
fstminimize binary.fst binary.fst

# cat the created binary so that it can be piped to reqd file and remove the redundant file
cat binary.fst
rm binary.fst