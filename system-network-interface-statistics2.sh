#!/bin/sh
read -r x
echo "$x"
set -- $x
unset -v x
shift 2 # date time
column_count=$#
column_number=0
for column_name
do
	eval sum$column_number=0
	eval max$column_number=0
	column_number=$((column_number+1))
done
unset -v column_number
read -r x
set -- $x
unset -v x
shift 2 # date time
sample_count=0
while true
do
	read -r date time ys
	test $? -gt 0 && break
	printf '%s %s' $date $time
	unset -v date time
	column_number=0
	for y in $ys
	do
		x=$1
		shift
		d=$((y-x))
		unset -v x
		unset -v y
		printf ' %16u' $d
		eval sum=\$sum$column_number
		sum=$((sum+d))
		eval sum$column_number=$sum
		unset -v sum
		eval max=\$max$column_number
		max=$((d>max?d:max))
		eval max$column_number=$max
		unset -v max
		unset -v d
		column_number=$((column_number+1))
	done
	unset -v column_number
	echo
	set -- $ys
	unset -v ys
	sample_count=$((sample_count+1))
done
printf '%19s' 'sum'
column_number=0
while test $column_number -lt $column_count
do
	eval sum=\$sum$column_number
	printf ' %16u' $sum
	unset -v sum
	column_number=$((column_number+1))
done
unset -v column_number
echo
printf '%19s' 'average'
column_number=0
while test $column_number -lt $column_count
do
	eval sum=\$sum$column_number
	unset -v sum$column_number
	printf ' %16u' $((sum/sample_count))
	unset -v sum
	column_number=$((column_number+1))
done
unset -v column_number
echo
unset -v sample_count
printf '%19s' 'maximum'
column_number=0
while test $column_number -lt $column_count
do
	eval max=\$max$column_number
	unset -v max$column_number
	printf ' %16u' $max
	unset -v max
	column_number=$((column_number+1))
done
unset -v column_number
echo
unset -v column_count
