for i in 0{1..9}{10..24}
	do
	list2=$(find -mindepth 1 -type f -wholename "*$i-02-01*/accepted_hits.bam")
	echo "$list2" > list.txt
	bamtools merge -list list.txt -out sample_"$i"
	printf $"Merge done\n"
	done
