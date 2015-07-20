#!/bin/bash

function usage() {
	cat <<EOF

	USAGE ${0} -i -o

	-i The input file
	-o The output fle

	This script takes a fasta file that has newlines in the sequence and removes them.

	e.g. 	>accession1
		ATGGCCCATG
		GGATCCTAGC
		>accession2
		GATATCCATG
		AAACGGCTTA
	
	Will be converted to this:
		>accession1
		ATGGCCCATGGGATCCTAGC
		>accession2
		GATATCCATGAAACGGCTTA
EOF
}

if [ $# -lt 2 ]; then
	usage
	exit 1
fi

INPUT=
OUTPUT=

while getopts i:o: flag; dp
	case $flag in
		i) INPUT=$OPTARG
		;;
		o) OUTPUT=$OPTARG
		;;
		?)
		usage
		exit 1
		;;
	esac
done

awk '/^>/{print s? s"\n"$0:$0;s="";next}{s=s sprintf("%s",$0)}END{if(s)print s}' $INPUT > $OUTPUT
