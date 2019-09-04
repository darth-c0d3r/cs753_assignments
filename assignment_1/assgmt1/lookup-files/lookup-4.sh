#! /bin/bash

# $1 : Prefix FST File [QPrefix.fst]
# $2 : Input Symbol Table for QPrefix [lex-files/let-out.txt]
# $3 : Suffix FST File [QSuffix.fst]
# $4 : Input Symbol Table for QSuffix [lex-files/let-out_rev.txt]
# $5 : Input Word

# Aim : Break the input word into prefixes and suffixes
# 		Get pronunciation of prefix by using QPrefix
# 		Get pronunciation of suffix by inverting suffix and using QSuffix
#		Get final pronunciation by appending first with reverse of second
# 		However, if pronunciation of whole word is given, no need to break

# get pronunciation of complete word
PRONUN=$(./lookup-3.sh $1 $2 $5)

# if it exists, no need to break
if [ "$PRONUN" = "<OOV>" ]; then

	WORD=$5
	LEN=${#WORD}

	# iterate for getting all partitions
	for ((i=1; i<LEN; i++))
	do
		# extract prefix and suffix
		PREFIX=${WORD:0:i}
		SUFFIX=$(echo ${WORD:i:LEN} | rev)

		# get output for prefix
		PRE_PRONUN=$(./lookup-3.sh $1 $2 $PREFIX)
		SUF_PRONUN=$(./lookup-3.sh $3 $4 $SUFFIX | rev)

		if [ "$PRE_PRONUN" = "<OOV>" ] || [ "$SUF_PRONUN" = ">VOO<" ]; then
			continue
		else
			# print the complete pronunciation
			echo $PRE_PRONUN $SUF_PRONUN
			break 
		fi
	done

else
	echo $PRONUN
fi