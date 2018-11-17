#!/usr/bin/env bash

aws cloudformation validate-template --profile koliber --template-body file://networks/base-vpc-template.yaml

aws cloudformation create-stack --stack-name cs-aws-dev-hmk-networks \
    --template-body file://networks/base-vpc-template.yaml \
    --parameters file://networks/base-vpc-parameters.json \
    --profile koliber

aws cloudformation validate-template --profile koliber --template-body file://networks/base-vpc-flow-logs-iam-role.yaml

aws cloudformation create-stack --stack-name cs-aws-dev-hmk-networks-role \
    --template-body file://networks/base-vpc-flow-logs-iam-role.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --profile koliber



