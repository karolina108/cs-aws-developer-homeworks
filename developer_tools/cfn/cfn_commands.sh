#!/usr/bin/env bash
AWS_PROFILE=koliberpro

aws cloudformation validate-template \
    --template-body file://developer_tools/cfn/resources_template.yaml \
    --profile ${AWS_PROFILE}
