#!/bin/sh

INSTANCENAME=Docker

INSTANCETYPE=t2.micro

AMI_ID=ami-0f5ee92e2d63afc18

ZONE=subnet-0f7ec0ece3a873bb1

COUNTS=1

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count $COUNTS --instance-type $INSTANCETYPE --key-name filinta --security-group-ids sg-08a5b7d4856dedfe6 --subnet-id $ZONE --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCENAME'}]' --query 'Instances[0].InstanceId'  --output text)

sleep 30

echo "Instance Created Successfully"

PUBLICIP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].PublicIpAddress' | cut -d "[" -f2 | cut -d "]" -f1 | tr -d '" ')

echo "$PUBLICIP ansible_user=ubuntu ansible_ssh_private_key_file=/home/ansible/filinta.pem" >> /etc/ansible/hosts
