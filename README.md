# system-network-interface-statistics

## system-network-interface-statistics.sh

- captures statistics for each network interface listed in /sys/class/net/
  - outputs them to a .txt file named the interface's name
- requires one input:
  - number of seconds to sample for
- calls the following two scripts

## system-network-interface-statistics1.sh

- samples a network interface's counts at a one second frequency
  - outputs them to standard output
- requires two inputs:
  - a device name from those listed in /sys/class/net/
  - number of seconds to sample for

## system-network-interface-statistics2.sh

- processes output from a run of the previous script
  - expects it in standard input
- outputs to standard output:
  - each per second sample converted to its increase
  - for the run, each count's sum and per second average and maximum
