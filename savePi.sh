#!/bin/bash
#disable swap
swap_off()
{
	sudo swapoff --all
}

#force noatime
noatime()
{
	sudo sed s/defaults\ /defaults,noatime/g < /etc/fstab
}

#mount /var/tmp in RAM
mount_tmp_in_ram()
{
	sudo /bin/bash -c 'echo "tmpfs /var/tmp tmpfs nodev,nosuid,size=50M 0 0" >> /etc/fstab'
}


main()
{
	/bin/echo -n "Do you want to turn off swap? [Y/n]:"
	read response
	if checkyesno ${response} ; then
		swap_off
	fi

	/bin/echo -n "Do you want to force noatime? [Y/n]:"
	read response
	if checkyesno ${respnse} ; then
		noatime
	fi

	/bin/echo -n "Do you want to mount tmp filesystem in RAM? [Y/n]:"
	read response
	if checkyesno ${response} ; then
		mount_tmp_in_ram
	fi
}

checkyesno()
{
	case $1 in
		# "yes", "true", "on", or "1"
		[Yy][Ee][Ss]|[Tt][Rr][Uu][Ee]|[Oo][Nn]|[Yy]|1)
		return 0
		;;

		# "no", "false", "off", or "0"
		[Nn][Oo]|[Ff][Aa][Ll][Ss][Ee]|[Oo][Ff][Ff]|[Nn]|0)
		return 1
		;;

		*)
		return 1
		;;
	esac
}

main
