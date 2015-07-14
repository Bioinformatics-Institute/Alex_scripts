#!/bin/bash

function usage() {
	cat <<EOF
	Usage:[bash or ./] ${0} -1 -2 -o
	If invoked with sh ${0}, the script will fail with an error
	-1 First fastq file to interleave
	-2 Second fastq file to interleave
	-o Output fastq file
EOF
}

if [ $# -lt 3 ]; then
	usage
	exit 1
fi

OPTIONA=
OPTIONB=
OPTIONC=

while getopts 1:2:o: flag; do
	case "$flag" in
		1) OPTIONA="$OPTARG"
		;;
		2) OPTIONB="$OPTARG"
		;;
		o) OPTIONC="$OPTARG"
		;;
		?)
		usage
		exit 1
		;;
	esac
done

paste <(paste - - - - < "$OPTIONA") <(paste - - - - < "$OPTIONB") | tr '\t' '\n' > "$OPTIONC"
