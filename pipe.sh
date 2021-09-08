#!/bin/sh
#sudo apt-get install jq 
sudo apt-get update -y
sudo apt-get install -y dos2unix
touch state.json
aws codepipeline get-pipeline-state --name buildpipe > state.json
sudo chmod 777 state.json
STATE=`jq .stageStates[0].latestExecution.status state.json`
if [ "$STATE" == "InProgress" ]
then
  echo "InProgress......"
  timeout 50 
  aws codepipeline get-pipeline-state --name buildpipe > state.json
  sudo chmod 777 state.json
  STATE=`jq .stageStates[0].latestExecution.status state.json`  
fi
