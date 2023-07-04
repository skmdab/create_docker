#!/bin/bash

INSTANCENAME=Docker

INSTANCETYPE=t2.micro

AMI_ID=ami-0f5ee92e2d63afc18

ZONE=subnet-0f7ec0ece3a873bb1

COUNTS=1

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count $COUNTS --instance-type $INSTANCETYPE --key-name filinta --security-group-ids sg-08a5b7d4856dedfe6 --subnet-id $ZONE --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCENAME'}]' --query 'Instances[0].InstanceId'  --output text)

sleep 20
