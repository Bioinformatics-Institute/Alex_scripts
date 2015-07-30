#!/bin/bash

for i in *.fastq
do
	grep -A 2 -B 1 --no-group-separator "(N)\1+" "$i" | diff "$i" - | sed '/^[0-9][0-9]*/d; s/^. //; /^---$/d' > "$i"_cleaned.fastq
done

