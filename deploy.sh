#!/bin/bash
aws --region=us-east-1 cloudformation deploy --stack-name=wordpress --template-file=sunshinebrass-stack.yaml
