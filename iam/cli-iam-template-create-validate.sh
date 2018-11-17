#!/usr/bin/env bash
PROFILE=MY_PROFILE

aws cloudformation validate-template --profile ${PROFILE} --template-body file://create-s3-bucket.yaml;

aws cloudformation create-stack \
 --profile ${PROFILE} \
 --stack-name cs-aws-dev-iam-hmk-stack-011 \
 --template-body file://create-s3-bucket.yaml \
 --parameters ParameterKey=BucketNumber,ParameterValue=011,UsePreviousValue=false \
    ParameterKey=AccessControl,ParameterValue=Private \
 --capabilities CAPABILITY_NAMED_IAM

aws cloudformation delete-stack \
    --profile ${PROFILE} \
    --stack-name cs-aws-dev-iam-hmk-stack-011