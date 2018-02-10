#!/bin/bash
aws ec2 describe-instances \
  --output text \
  --filter Name="key-name",Values="adam-jones-keypair" \
  --filter Name="instance-state-name","Values=running" \
  --query "Reservations[*].Instances[*].{StartTime:LaunchTime,ImageId:ImageId,ZName:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId,PublicIp:PublicIpAddress,PrivateIp:PrivateIpAddress}" |\
sort -k 5,6 -t ' ' |\
pr -te16 
