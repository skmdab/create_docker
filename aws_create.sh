#!/bin/sh

progress_bar() {
  duration="$1"
  bar_length=75
  sleep_duration=$(echo "$duration / $bar_length" | bc)

  i=0
  while [ "$i" -le "$bar_length" ]; do
    printf "\r["

    j=0
    while [ "$j" -lt "$i" ]; do
      printf "="
      j=$((j+1))
    done

    printf ">"

    j=$((i+1))
    while [ "$j" -lt "$bar_length" ]; do
      printf " "
      j=$((j+1))
    done

    printf "] %d%%" "$((i*100/bar_length))"

    sleep "$sleep_duration"
    i=$((i+1))
  done

  printf "\n"
}

echo "Creating Docker server"

INSTANCENAME=Docker

INSTANCETYPE=t2.medium

AMI_ID=ami-0f5ee92e2d63afc18

ZONE=subnet-0f7ec0ece3a873bb1

COUNTS=1

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count $COUNTS --instance-type $INSTANCETYPE --key-name filinta --security-group-ids sg-08a5b7d4856dedfe6 --subnet-id $ZONE --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$INSTANCENAME'}]' --query 'Instances[0].InstanceId'  --output text)

progress_bar 75

echo "Docker Server Created Successfully!"

PUBLICIP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].PublicIpAddress' | cut -d "[" -f2 | cut -d "]" -f1 | tr -d '" ')

PCLINE="[$INSTANCENAME]
$PUBLICIP ansible_user=ec2-user ansible_ssh_private_key_file=/home/ansible/filinta.pem"

PHLINE="[$INSTANCENAME]\n\n$PUBLICIP ansible_user=ec2-user ansible_ssh_private_key_file=filinta.pem"

PATH="/root/.jenkins/workspace/$INSTANCENAME"

if [ "$(echo "$PWD")" = "$PATH" ]; then
  echo "$PCLINE" > hosts
else
  echo "$PHLINE" > hosts
fi

