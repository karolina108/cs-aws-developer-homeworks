#!/usr/bin/env bash
AWS_PROFILE=koliberpro

aws cloudformation validate-template \
    --template-body file://developer_tools/cfn/resources_template.yaml \
    --profile ${AWS_PROFILE}

aws cloudformation validate-template \
    --template-body file://developer_tools/cfn/buckets_template.yaml \
    --profile ${AWS_PROFILE}

aws cloudformation create-stack \
    --stack-name cs-aws-dev-tools-buckets \
    --template-body file://developer_tools/cfn/buckets_template.yaml \
    --profile ${AWS_PROFILE}

aws cloudformation create-stack \
    --stack-name cs-aws-dev-tools-resources \
    --template-body file://developer_tools/cfn/resources_template.yaml \
    --profile ${AWS_PROFILE}


