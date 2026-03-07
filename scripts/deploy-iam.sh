#!/bin/bash
# OpenAI News Summary - IAM Role デプロイスクリプト
#
# 使用方法:
#   ./scripts/deploy-iam.sh <GitHub Org> <GitHub Repo> [既存 OIDC Provider ARN]
#
# 例:
#   ./scripts/deploy-iam.sh myorg openai-news-summary
#   ./scripts/deploy-iam.sh myorg openai-news-summary arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <GitHub Org> <GitHub Repo> [OIDC Provider ARN]"
    echo ""
    echo "Examples:"
    echo "  $0 myorg openai-news-summary"
    echo "  $0 myorg openai-news-summary arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
    exit 1
fi

GITHUB_ORG=$1
GITHUB_REPO=$2
OIDC_PROVIDER_ARN=${3:-""}

STACK_NAME="openai-news-summary-cicd"
TEMPLATE_FILE="$(dirname "$0")/cfn-github-oidc-iam.yaml"

echo "Deploying OpenAI News Summary CI/CD IAM Role..."
echo "  GitHub Org:  $GITHUB_ORG"
echo "  GitHub Repo: $GITHUB_REPO"
echo "  Stack Name:  $STACK_NAME"
echo ""

PARAMS="ParameterKey=GitHubOrg,ParameterValue=$GITHUB_ORG"
PARAMS="$PARAMS ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO"

if [ -n "$OIDC_PROVIDER_ARN" ]; then
    echo "  Using existing OIDC Provider: $OIDC_PROVIDER_ARN"
    PARAMS="$PARAMS ParameterKey=OIDCProviderArn,ParameterValue=$OIDC_PROVIDER_ARN"
fi

aws cloudformation deploy \
    --template-file "$TEMPLATE_FILE" \
    --stack-name "$STACK_NAME" \
    --parameter-overrides $PARAMS \
    --capabilities CAPABILITY_NAMED_IAM

echo ""
echo "Deployment complete!"
echo ""
echo "Outputs:"
aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --query 'Stacks[0].Outputs' \
    --output table

echo ""
echo "Next steps:"
echo "1. Copy the RoleArn from the outputs above"
echo "2. Add it as a secret named 'AWS_ROLE_ARN' in your GitHub repository"
echo "   Settings > Secrets and variables > Actions > New repository secret"
