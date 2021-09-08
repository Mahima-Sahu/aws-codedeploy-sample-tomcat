#!/bin/sh
aws codepipeline start-pipeline-execution --name buildpipe
touch state.json
aws codepipeline get-pipeline-state --name buildpipe > state.json
SOURCE=`jq .stageStates[0].latestExecution.status state.json`
DEPLOY=`jq .stageStates[2].latestExecution.status state.json`
BUILD=`jq .stageStates[1].latestExecution.status state.json`
while [ $SOURCE = "InProgress" ] || [ $DEPLOY = "InProgress" ] || [ $BUILD = "InProgress" ]
do
    echo "Pipeline is InProgress......"
    sleep 50s
    aws codepipeline get-pipeline-state --name buildpipe > state.json
    SOURCE=`jq .stageStates[0].latestExecution.status state.json`
    DEPLOY=`jq .stageStates[2].latestExecution.status state.json`
    BUILD=`jq .stageStates[1].latestExecution.status state.json`
done
if [ $SOURCE = "Succeeded" ] && [ $DEPLOY = "Succeeded" ] && [ $BUILD = "Succeeded" ]
then
    echo "Pipeline-- Succeeded --"
elif [ $SOURCE = "Stopped" ] || [ $DEPLOY = "Stopped" ] || [ $BUILD = "Stopped" ]
then
    echo "Pipeline is-- Stopped --"
    exit 1
else
    echo "Pipeline-- Failed --!!"
    exit 1
fi
