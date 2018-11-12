#!/usr/bin/env bash

aws cloudformation validate-template --profile koliber --template-body file://create-s3-bucket.yaml;

aws cloudformation create-stack \
 --profile koliber \
 --stack-name cs-aws-dev-iam-hmk-stack-011 \
 --template-body file://create-s3-bucket.yaml \
 --parameters ParameterKey=BucketNumber,ParameterValue=011,UsePreviousValue=false \
    ParameterKey=AccessControl,ParameterValue=Private \
 --capabilities CAPABILITY_NAMED_IAM

aws cloudformation delete-stack \
    --profile koliber \
    --stack-name cs-aws-dev-iam-hmk-stack-011