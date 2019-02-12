#!/bin/sh
pushd `dirname $0`

# variable
source ./_variable.sh

echo "delete bucket"
aws s3 rm s3://$SYS_NAME --recursive

echo "delete code repository"
aws codecommit delete-repository --repository-name $SYS_NAME

echo "delete deploy stack"
aws cloudformation delete-stack --stack-name $SYS_NAME-deploy
echo "deploy stack deleting ..."
aws cloudformation wait stack-delete-complete --stack-name $SYS_NAME-deploy

sleep 1

echo "delete stack"
aws cloudformation delete-stack --stack-name $SYS_NAME
echo "stack deleting ..."
aws cloudformation wait stack-delete-complete --stack-name $SYS_NAME

echo "remove finished !"

exit 0
