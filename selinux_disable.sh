#!/bin/bash

function SELinuxQuestion() {
	while true; do
		read -p "Do you want to Disable SELinux?" yn
		case $yn in
			[Yy]* ) SELinuxConf;;
			[Nn]* ) quit;;
			* ) "Please press 1 or 2.";;
		esac
	done
}


function SELinuxConf() {
	echo "Disabling SELinux"
	s=`cat /etc/selinux/config | grep "SELINUX=disabled"`
	if [ -n "$s" ]; then
	echo "SELinux is already disabled"
	else
		s=`cat /etc/selinux/config | grep "SELINUX=permissive"`
		if [ -n "$s" ]; then
		echo "SELinux is in permissive mode, not changing state"
		else
		SELinuxDisable
		fi
	fi
	quit
}


function SELinuxDisable() {
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
	s=`cat /etc/selinux/config | grep "SELINUX=disabled"`
	if [ -n "$s" ]; then
	echo Success
	else
	echo Failure
	fi
}

function quit {
	exit
}



SELinuxQuestion
