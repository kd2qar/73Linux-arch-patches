#! /bin/bash
# envioment checking

#for first run
BAPSYSINFO=${BAPDIR}/cache/cpu.bap
set -e #any errors stop now
MYCALL=$(ls MYCALL.* | sed 's/MYCALL.//')
CALL=$MYCALL

export CALL
export MYCALL

trap 'catch' ERR
catch() {
echo -e "\nCRITICAL: parsing error on:"
}

pi_check(){
	#check is Pi OS is 32 or 64 bit
	if [ `getconf LONG_BIT` = 32 ]; then
		CPU=32
	elif [ `getconf LONG_BIT` = 64 ]; then
		CPU=64
	fi
}

#lscpu to pull out args with sed to share to script.
rm -f /tmp/bap-env-*
lscpu > /tmp/bap-env-lscpu
eval "$(sed -n 's/^ID=/distribution=/p' /etc/os-release)"
eval "$(sed -n 's/^VERSION_ID=/version=/p' /etc/os-release | tr -d '"')"
arch=$(cat /tmp/bap-env-lscpu | grep Architecture: | awk '{print $2}')
#eval "$(sed -n 's/^CPU(s):                          /cpu=/p' /tmp/bap-env-lscpu)"
cpu=$(grep processor.*: /proc/cpuinfo | wc -l)


case "$arch" in
    armv7l | armv6l)
        pi_check
        ;;
    aarch64)
        pi_check
        ;;
    x86_64)
        CPU=64
        ;;
    x86)
        CPU=32
        ;;
    *)
        echo -e "Unknown: $arch with $cpu cores"
        ;;
esac

case "$distribution" in
    raspbian)
        ls > /dev/null #nothing yet
        ;;
    debian)
        ls > /dev/null #nothing yet
        ;;
    linuxmint)
        ls > /dev/null #nothing yet
        ;;
    *)
        echo "Possibly Unsupported: $distribution $version you have a $arch with $cpu cores"
        ;;
esac

#set a config register for use by all apps first line is bits, second is core for make -j4
echo -e "$CPU\n$cpu\n$arch\n$distribution\n$MYCALL\n$(hostname -s)" > $BAPSYSINFO
echo -e "enviroment $CPU $arch $distribution"
exit 0
