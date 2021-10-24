#!/bin/bash

ENV=development
REGION=process.env.REGION
AWS_ACCOUNT_ID=process.env.AWS_ACCOUNT_ID
PROFILE=process.env.PROFILE

AWS_DOCKER_REGISTRY_URL=$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

docker logout $AWS_DOCKER_REGISTRY_URL
# Login in AWS container registry with your AWS credentials
aws ecr get-login-password --profile $PROFILE --region $REGION | docker login --username AWS --password-stdin $AWS_DOCKER_REGISTRY_URL

# Deploy app
eb deploy $ENV
# npm run deploy -- $ENV