#!/bin/bash

function SELinuxQuestion() {
	while true; do
		read -p "Do you want to set SELinux to Permissive mode?" yn
		case $yn in
			[Yy]* ) SELinuxConf;;
			[Nn]* ) quit;;
			* ) "Please press 1 or 2.";;
		esac
	done
}


function SELinuxConf() {
	echo "Setting SELinux to permissive mode"
	s=`cat /etc/selinux/config | grep "SELINUX=permissive"`
	if [ -n "$s" ]; then
	echo "SELinux is already in permissive mode"
	else
		s=`cat /etc/selinux/config | grep "SELINUX=disabled"`
		if [ -n "$s" ]; then
		StatusMsg "SELinux is disabled, not changing state"
		else
		SELinuxPerm
		fi
	fi
	quit
}


function SELinuxPerm() {
	sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
	s=`cat /etc/selinux/config | grep "SELINUX=permissive"`
	if [ -n "$s" ]; then
	Success
	else
	Failure
	fi
}

function quit {
	exit
}



SELinuxQuestion
