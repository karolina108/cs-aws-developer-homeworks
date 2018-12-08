#!/usr/bin/env bash
AWS_PROFILE=koliberpro

aws cloudformation validate-template \
    --template-body file://serverless_and_databases/cfn/dynamodb.yaml \
    --profile ${AWS_PROFILE}

aws cloudformation create-stack \
    --stack-name cs-aws-dev-dynamodb-guests \
    --template-body file://serverless_and_databases/cfn/dynamodb.yaml \
    --profile ${AWS_PROFILE}

