#!/bin/bash

# Run this script in the same directory as the files that you want to count

CPUS=16 # How many CPUs to use

# The number of tasks is found by listing and then counting the files that you want to process. Here they are all "sample_[0-9][0-9]". You should change the grep search to something that identifies your files.

TASKS=$(ls | grep "sample_[0-9][0-9]$" | wc -l) # How many things that need to be done (this counts the number of files in the directory with sample in the name)
echo "$TASKS"

while [ "$TASKS" -gt 0 ] # While tasks are remaining, do this loop
do
	{ # Do parallel tasks here
		if [ "$TASKS" -gt 9 ] # This if / else is a work-around for the file naming (single digits had a preceeding 0)
		then
			htseq-count -f bam -s reverse sample_"$TASKS" /scratch/nzgl00765/ercc/ERCC92.gtf > sample_"$TASKS"_htseq_count.txt
		else
			htseq-count -f bam -s reverse sample_0"$TASKS" /scratch/nzgl00765/ercc/ERCC92.gtf > sample_0"$TASKS"_htseq_count.txt
		fi
	} & # Ampersand need to spawn more tasks
	until [ `ps --no-headers -o pid --ppid=$$ | wc -w` -le $CPUS ]; # This checks everysecond to see if a task has finished
	do
		sleep 1
	done
	TASKS=$(( TASKS - 1 )) # Set tasks to the number remaining
done
wait # Wait for all processes to finish
echo "All finished :)" # Everything is done
