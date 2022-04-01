#!/bin/sh
set -x
scripts_directory_path_name=$(dirname $0)
for network_device_directory_path_name in /sys/class/net/*
do
	network_device_name=$(basename $network_device_directory_path_name)
	$scripts_directory_path_name/system-network-interface-statistics1.sh $network_device_name $1|\
	$scripts_directory_path_name/system-network-interface-statistics2.sh >$network_device_name.txt&
	unset -v network_device_name
done
unset -v network_device_directory_path_name
wait
