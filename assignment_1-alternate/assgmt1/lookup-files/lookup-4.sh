#! /bin/bash

# $1 : Prefix FST File [QPrefix.fst]
# $2 : Input Symbol Table for QPrefix [let-out.txt]
# $3 : Suffix FST File [QSuffix.fst]
# $4 : Input Symbol Table for QSuffix [let-out_rev.txt]
# $5 : Input Word

# Aim : Break the input word into prefixes and suffixes
# 		Get pronunciation of prefix by using QPrefix
# 		Get pronunciation of suffix by inverting suffix and using QSuffix
#		Get final pronunciation by appending first with reverse of second
# 		However, if pronunciation of whole word is given, no need to break

cd ./lookup-files
LSTP="../fst-files/${1}"
SYMP="../lex-files/${2}"
LSTS="../fst-files/${3}"
SYMS="../lex-files/${4}"

# get pronunciation of complete word
cd ..
PRONUN=$(./lookup-files/lookup-3.sh $LSTP $SYMP $5)

WORD=$5
LEN=${#WORD}

# Initialize Max Length and Optimal words
MAX_LEN=0
MAX_PRE=""
MAX_SUF=""

# iterate for getting all partitions
for ((i=0; i<=LEN; i++))
do
	# extract prefix and suffix
	PREFIX=${WORD:0:i}
	SUFFIX=$(echo ${WORD:i:LEN} | rev)

	# get output for prefix
	PRE_PRONUN=$(./lookup-files/lookup-3.sh $LSTP $SYMP $PREFIX)
	SUF_PRONUN=$(./lookup-files/lookup-3.sh $LSTS $SYMS $SUFFIX | rev)

	if [ "$PRE_PRONUN" = "<OOV>" ] || [ "$SUF_PRONUN" = ">VOO<" ]; then
		continue
	else
		
		NUM_PRE=$(($(echo "$PRE_PRONUN" | tr -cd ' ' | wc -c)+1))
		NUM_SUF=$(($(echo "$SUF_PRONUN" | tr -cd ' ' | wc -c)+1))

		# compare with current best
		if (( NUM_PRE + NUM_SUF >= MAX_LEN )); then
			#statements
			MAX_LEN=$((NUM_PRE+NUM_SUF))
			MAX_PRE=$PRE_PRONUN
			MAX_SUF=$SUF_PRONUN
		fi

	fi
done

echo $MAX_PRE $MAX_SUF