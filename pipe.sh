#!/bin/bash
#sudo apt-get install jq 
aws codepipeline get-pipeline-state --name buildpipe > state.json
sudo chmod 777 state.json
STATE=`jq .latestExecution.status ${{github.workspace}}/state.json`
if [ "$STATE" == "InProgress" ]; then
  echo "InProgress......"
  timeout 50 
  aws codepipeline get-pipeline-state --name buildpipe > state.json
  sudo chmod 777 state.json
  STATE=`jq .latestExecution.status ${{github.workspace}}/state.json`  
fi
if [ "$STATE" == "InProgress" ]; then
  echo "InProgress......"
  timeout 50 
  aws codepipeline get-pipeline-state --name buildpipe > state.json
  sudo chmod 777 state.json
  STATE=`jq .latestExecution.status ${{github.workspace}}/state.json`  
fi
if [ "$STATE" == "Succeeded" ]; then
  echo "Pipeline is Succeeded" 
if [ "$STATE" == "Failed" ]; then
  echo "Pipeline execution failed !!"
fi

