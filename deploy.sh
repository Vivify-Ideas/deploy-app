#!/bin/sh

function deploy() {
	echo "Starting deploy"
	url=$1
	services=$2
	output=$(curl -s -X POST "https://${url}/api/deploy" -H "Content-Type: application/json" -d ${services})
	task_id=$(echo $output | grep "task_id" | cut -d '"' -f 8)
	echo "Task id: $task_id"

	while true; do
		output=$(curl -s -X GET "https://${url}/api/tasks/${task_id}" -H "Accept: application/json")
		if ! echo $output | grep "Task is still running" >/dev/null; then
			break
		fi
		echo "Waiting for deploy to finish"
		sleep 5
	done

	if ! echo $output | grep "Successfully updated all services" >/dev/null; then
		echo $output
		echo "Deploy failed"
		exit 1
	fi

	echo "Deploy finished"
}

if [ ${BRANCH} = "master" ]; then
	deploy 'deploy-deploy.vivifyideas.com' '["deploy_app"]'
else
	echo "Branch ${BRANCH} is not deployable"
fi

