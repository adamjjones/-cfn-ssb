#!/bin/bash
aws ecs register-task-definition --cli-input-json file://sunshinebrass-docker-launch.json
aws ecs run-task --task-definition ssb-wordpress
