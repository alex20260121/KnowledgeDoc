#!/usr/bin/env bash

set -e
cluster_workers=('node-worker-1' 'node-worker-2' 'node-worker-3')

function sync_hadoop {
	src_path="/hadoop/src/hadoop-3.3.6"
	dest_path="/hadoop/src/"
	for host in ${cluster_workers[@]}
	do
		scp -r ${src_path} hadoop@${host}:${dest_path}
		if [ $? -eq 0 ];then
			echo -e "\033[1;32m$host scp done.\033[0m"
		fi
	done
}

function sync_env {
	sync_path="/home/hadoop/.bashrc"
	for host in ${cluster_workers[@]}
	do
		echo -e "\033[1;32mSynchronizing $host host.\033[0m"
		scp ${sync_path} hadoop@${host}:${sync_path}
	done
}

function cluster_state {
	all_members=('node-manager-1' 'node-worker-1' 'node-worker-2' 'node-worker-3')
	for member in ${all_members[@]}
	do
		echo -e "\033[1;32mChecking $member states\033[0m"
		ssh -n -o StrictHostKeyChecking=no hadoop@${member} "jps|grep -v Jps"
		echo
	done
}

function user_documentation {
	echo -e "\t\t- - - - - - - - - - - - - - - - -"
	echo "The script provides basic functions for managing Hadoop clusters."
	echo "Such as synchronizing cluster configuration files and environment variable files..."
	echo
	echo "Usage: $0 [command] [options]"
	echo "commands:"
	echo -e "\thadoop: All worker nodes will synchronize the Hadoop directory of the master node."
	echo -e "\tenvironment: All worker nodes will synchronize with the master node's ~/.bashrc file."
	echo -e "\tstates: Checking cluster state."
	echo -e "\t\t- - - - - - - - - - - - - - - - -"
}

case $1 in
	hadoop)
		sync_hadoop
		;;
	environment)
		sync_env
		;;
	states)
		cluster_state
		;;
	*)
		user_documentation
		;;
esac
