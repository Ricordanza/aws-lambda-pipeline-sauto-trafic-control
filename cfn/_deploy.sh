#!/bin/sh
pushd `dirname $0`

# variable
source ./_variable.sh

echo "create stack"
aws cloudformation create-stack \
    --stack-name $SYS_NAME \
    --template-body file://resource.yml \
    --parameters \
        ParameterKey=Stage,ParameterValue=$STAGE \
        ParameterKey=AppName,ParameterValue=$NAME \
        ParameterKey=BranchName,ParameterValue=$BRANCH \
    --capabilities 'CAPABILITY_NAMED_IAM'

echo "create stack operating ..."
aws cloudformation wait stack-create-complete --stack-name $SYS_NAME

echo "finished !"

popd

exit 0