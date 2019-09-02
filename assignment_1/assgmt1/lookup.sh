#! /bin/bash

# $1 : fst file
# $2 : the word

# make the 3 temporary files to make a new fst file
echo "0 1 $2 $2" > temp_fst.txt
echo "1" >> temp_fst.txt

echo "<eps> 0" > temp_in.txt
echo "$2 1" >> temp_in.txt

cp temp_in.txt temp_out.txt

# make a new temporary fst file
fstcompile --isymbols=temp_in.txt --osymbols=temp_out.txt --keep_isymbols --keep_osymbols temp_fst.txt binary.fst

# remove the temporary files
rm temp_fst.txt
rm temp_in.txt
rm temp_out.txt

# sort the FSTs before composing
fstarcsort --sort_type=olabel binary.fst binary.fst
fstarcsort --sort_type=ilabel $1 new_binary.fst

# take composition of the 2 binary fst files
# take the output into the original binary
fstcompose binary.fst new_binary.fst binary.fst
fstprint binary.fst temp

rm binary.fst
rm new_binary.fst