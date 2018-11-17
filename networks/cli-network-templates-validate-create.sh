#!/usr/bin/env bash
PROFILE=MY_PROFILE

aws cloudformation validate-template --profile ${PROFILE} --template-body file://networks/base-vpc-template.yaml

aws cloudformation create-stack --stack-name cs-aws-dev-hmk-networks \
    --template-body file://networks/base-vpc-template.yaml \
    --parameters file://networks/base-vpc-parameters.json \
    --profile ${PROFILE}

aws cloudformation validate-template --profile ${PROFILE} --template-body file://networks/base-vpc-flow-logs-iam-role.yaml

aws cloudformation create-stack --stack-name cs-aws-dev-hmk-networks-role \
    --template-body file://networks/base-vpc-flow-logs-iam-role.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --profile ${PROFILE}

aws cloudformation create-stack --stack-name cs-aws-dev-hmk-networks-flow-logs \
    --template-body file://networks/base-vpc-flow-logs.yaml \
    --parameters file://networks/base-vpc-parameters.json \
    --capabilities CAPABILITY_NAMED_IAM \
    --profile ${PROFILE}



