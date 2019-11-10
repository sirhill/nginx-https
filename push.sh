#!/bin/bash

GITLAB_PROJECT=platform
GITLAB_USERNAME=GITLAB_USER_NAME
GITLAB_API_TOKEN=GITLAB_API_TOKEN

sudo docker login registry.gitlab.com -u $GITLAB_USERNAME -p $GITLAB_API_TOKEN
if [ $? -eq 0 ];
then
  sudo docker tag sirhill/nginx-https registry.gitlab.com/$GITLAB_PROJECT/nginx-https
  sudo docker push registry.gitlab.com/$GITLAB_PROJECT/ningx-https
fi
