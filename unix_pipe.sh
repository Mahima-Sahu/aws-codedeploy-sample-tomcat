#!/bin/bash
aws codepipeline start-pipeline-execution --name buildpipe
touch state.json
aws codepipeline get-pipeline-state --name buildpipe > state.json
SOURCE=`jq .stageStates[0].latestExecution.status state.json`
DEPLOY==`jq .stageStates[2].latestExecution.status state.json`
while ([ $SOURCE = "InProgress" ] && [ $DEPLOY = "InProgress" ]) || ([ $SOURCE = "Succeeded" ] && [ $DEPLOY = "InProgress" ])
do
    echo "Pipeline is InProgress......"
    timeout 50 
    aws codepipeline get-pipeline-state --name buildpipe > state.json
    SOURCE=`jq .stageStates[0].latestExecution.status state.json`
    DEPLOY=`jq .stageStates[2].latestExecution.status state.json`
done
if ([ $SOURCE = "Succeeded" ] && [ $DEPLOY = "Succeeded" ])
then
    echo "Pipeline Succeeded"
else
    echo "Pipeline failed"
    exit 1
fi
