#!/bin/bash

sudo apt-get install jq -y

touch state.json

aws codepipeline get-pipeline-state --name buildpipe > state.json
STATE=`jq stageStates[latestExecution.status]`


if [ "$STATE" = "InProgress" ]; then
  echo "InProgress......"
  timeout 50 
  aws codepipeline get-pipeline-state --name buildpipe > state.json
  STATE=`jq stageStates[latestExecution.status]`  
fi
if [ "$STATE" = "InProgress" ]; then
  echo "InProgress......"
  timeout 50 
  aws codepipeline get-pipeline-state --name buildpipe > state.json
  STATE=`jq stageStates[latestExecution.status]`  
fi

if [ "$STATE" = "Succeeded" ]; then
  echo "Pipeline is Succeeded"
fi
if [ "$STATE" = "Failed" ]; then
  echo "Pipeline execution failed !!"
fi
