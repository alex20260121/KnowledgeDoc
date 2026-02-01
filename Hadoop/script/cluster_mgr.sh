#!/usr/bin/env bash

# This script manager the hadoop cluster.
set -e

function usage {
	echo -e "\033[1;31mThis script manager the hadoop cluster.\033[0m"
	echo "Usage: $0 [command] [args]..."
	echo -e "\tcommand:"
	echo -e "\t\tsync_hadoop: to sync hadoop installed directory."
	echo -e "\t\tsync_env: to sync '~/.bashrc' from hadoop user environment variables."
	echo -e "\t\tcheck_stats: Checking hadoop cluster proccess."
	echo -e "\t\tstart_history: launch JobHistory server to target host."
	echo -e "\t\t\targs: Hostname or IPAddress."
	echo -e "\t\tstop_history: shutdown JobHistory server to target host."
	echo -e "\t\t\targs: Hostname or IPAddress."
	echo "Example: $0 sync_hadoop "
	echo -e "\tto sync hadoop installed directory."

}

function sync_installed_hadoop_dir {
	hosts_list=(node-worker-1 node-worker-2 node-worker-3)
	src_dir=/hadoop/src/hadoop-3.3.6
	dest_dir=/hadoop/src
	for host in ${hosts_list[@]}
	do
		scp -r -o StrictHostKeyChecking=no ${src_dir} hadoop@${host}:${dest_dir}
	done
}

function sync_environment_variables {
	hosts_list=(node-worker-1 node-worker-2 node-worker-3)
	target_file=/home/hadoop/.bashrc
	for host in ${hosts_list[@]}
	do
		scp -o StrictHostKeyChecking=no ${target_file} hadoop@${hosts}:${target_file}
	done
}

function checking_cluster_proccess_stats {
	hosts_list=(node-manager-1 node-worker-1 node-worker-2 node-worker-3)
	for host in ${hosts_list[@]}
	do
		echo $host
		ssh -n -o StrictHostKeyChecking=no hadoop@${host} jps
		echo
	done
}

function launch_JobHistory_server {
	JobHistory_hostname=$1
	JobHistory_server_counter=$(ssh -n -o StrictHostKeyChecking=no hadoop@${JobHistory_hostname} "jps|grep JobHistoryServer|wc -l")
	if [ ${JobHistory_server_counter} -eq 0 ];then
		echo -e "\033[1;31mLaunching JobHistory server at ${JobHistory_hostname}.\033[0m"
		ssh -n -o StrictHostKeyChecking=no hadoop@${JobHistory_hostname} "mapred --daemon start historyserver"
		if [ $? -eq 0 ];then
			echo -e "\033[1;32mFinished.\033[0m"
		else
			echo -e "\033[1;31mFailed.\033[0m"
		fi
	else
		echo -e "\033[1;32mThe JobHistory server already running at $JobHistory_hostname.\033[0m"
	fi
}

function shutdown_JobHistory_server {
	JobHistory_hostname=$1
	JobHistory_server_counter=$(ssh -n -o StrictHostKeyChecking=no hadoop@${JobHistory_hostname} "jps|grep JobHistoryServer|wc -l")
	if [ ${JobHistory_server_counter} -eq 0 ];then
		echo -e "\033[1;32mThe JobHistory server is already shutdowned at ${JobHistory_hostname}.\033[0m"
	else
		echo -e "\033[1;31mShuting down Jobhistory server at ${JobHistory_hostname}.\033[0m"
		ssh -n -o StrictHostKeyChecking=no hadoop@${JobHistory_hostname} "mapred --daemon stop historyserver"
		if [ $? -eq 0 ];then
			echo -e "\033[1;32mFinished\033[0m"
		else
			echo -e "\033[1;31mFailed\033[0m"
		fi
	fi
}
case $1 in
	sync_hadoop)
		sync_installed_hadoop_dir
		;;
	sync_env)
		sync_environment_variables
		;;
	check_stats)
		checking_cluster_proccess_stats
		;;
	start_history)
		launch_JobHistory_server $2
		;;
	stop_history)
		shutdown_JobHistory_server $2
		;;
	*)
		usage
		;;
esac
