#!/bin/sh
aws codepipeline start-pipeline-execution --name buildpipe
touch state.json
aws codepipeline get-pipeline-state --name buildpipe > state.json
count=0
SOURCE=`jq -r .stageStates[0].latestExecution.status state.json`
DEPLOY=`jq -r .stageStates[2].latestExecution.status state.json`
BUILD=`jq -r .stageStates[1].latestExecution.status state.json`
while [ $SOURCE = "InProgress" ] || [ $DEPLOY = "InProgress" ] || [ $BUILD = "InProgress" ]
do
    echo "Pipeline is InProgress......"
    sleep 65s
    aws codepipeline get-pipeline-state --name buildpipe > state.json
    SOURCE=`jq -r .stageStates[0].latestExecution.status state.json`
    DEPLOY=`jq -r .stageStates[2].latestExecution.status state.json`
    BUILD=`jq -r .stageStates[1].latestExecution.status state.json`
    count=$((count+1))
    if [ $count = 3 ]
    then 
      break
    fi
done
if [ $SOURCE = "Succeeded" ] && [ $DEPLOY = "Succeeded" ] && [ $BUILD = "Succeeded" ]
then
    echo "Pipeline-- Succeeded --"
elif [ $SOURCE = "Stopped" ] || [ $DEPLOY = "Stopped" ] || [ $BUILD = "Stopped" ]
then
    echo "Pipeline is-- Stopped --"
    exit 1
elif [ $SOURCE = "InProgress" ] || [ $DEPLOY = "InProgress" ] || [ $BUILD = "InProgress" ]
then
    echo "Pipeline is-- InProgress for very long time > $count minutes --"
    exit 1
else
    echo "Pipeline-- Failed --!!"
    exit 1
fi
