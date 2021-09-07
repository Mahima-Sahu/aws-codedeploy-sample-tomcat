#!/bin/sh
#sudo apt-get install jq 
touch state.json
aws codepipeline get-pipeline-state --name buildpipe > state.json
STATE=`jq .stageStates[latestExecution.status] state.json`
if [ "$STATE" = "InProgress" ]
  then
    echo "InProgress......"
    timeout 50 
    aws codepipeline get-pipeline-state --name buildpipe > state.json
    STATE=`jq .stageStates[latestExecution.status] state.json`  
fi
if [ "$STATE" = "InProgress" ]
  then
    echo "InProgress......"
    timeout 50 
    aws codepipeline get-pipeline-state --name buildpipe > state.json
    STATE=`jq .stageStates[latestExecution.status] state.json`  
fi
if [ "$STATE" = "Succeeded" ]
  then
    echo "Pipeline is Succeeded"
elif [ "$STATE" = "Failed" ]
  then
    echo "Pipeline execution failed !!"
fi
