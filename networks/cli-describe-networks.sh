#!/usr/bin/env bash
VPC_ID=MY_VPC_ID
PROFILE=MY_PROFILE

echo '---------------'
echo 'VPC'
echo '---------------'
aws ec2 describe-vpcs --vpc-ids ${VPC_ID} --profile ${PROFILE}

echo '---------------'
echo 'SUBNETS'
echo '---------------'
aws ec2 describe-subnets --filter Name=vpc-id,Values=${VPC_ID} --profile ${PROFILE}

echo '---------------'
echo 'ROUTE TABLES'
echo '---------------'

aws ec2 describe-route-tables --filter Name=vpc-id,Values=${VPC_ID} --profile ${PROFILE}

echo '---------------'
echo 'NAT GATEWAYS'
echo '---------------'

aws ec2 describe-nat-gateways --filter Name=vpc-id,Values=${VPC_ID} --profile ${PROFILE}

echo '---------------'
echo 'SECURITY GROUPS'
echo '---------------'

aws ec2 describe-security-groups --filter Name=vpc-id,Values=${VPC_ID} --profile ${PROFILE}