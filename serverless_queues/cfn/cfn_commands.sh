#!/usr/bin/env bash
AWS_PROFILE=koliberpro

aws cloudformation validate-template \
    --template-body file://serverless_queues/cfn/sqs_queue.yaml \
    --profile ${AWS_PROFILE}

aws cloudformation create-stack \
    --stack-name cs-aws-dev-application-guests \
    --template-body file://serverless_queues/cfn/sqs_queue.yaml \
    --profile ${AWS_PROFILE}

