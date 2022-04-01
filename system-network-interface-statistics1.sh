#!/bin/sh
statistics_file_names='rx_bytes tx_bytes rx_packets rx_dropped multicast tx_packets'
statistic_character_count=16
statistics_header_format_string=
for file_name in $statistics_file_names
do
	statistics_header_format_string=$statistics_header_format_string\ %${statistic_character_count}s
done
unset -v file_name
printf 'year-ym-md dh:hm:ms'"$statistics_header_format_string"'\n' $statistics_file_names
i=0
while test $i -lt $2
do
	printf "$(/bin/date +%Y-%m-%d\ %H:%M:%S)"
	for file_name in $statistics_file_names
	do
		printf \ %${statistic_character_count}u $(cat /sys/class/net/$1/statistics/$file_name)
	done
	echo
	unset -v file_name
	sleep 1
	i=$((i+1))
done
unset -v statistics_header_format_string
unset -v statistic_character_count
unset -v statistics_file_names
