#!/usr/bin/env bash

set -euo pipefail

# -------- Default Config --------
SCRIPT_DIR=$(dirname "$(realpath "$0")")
STACK_NAME="MyCustomVPCStack"
TEMPLATE_FILE="$SCRIPT_DIR/../vpc-setup-using-chatgpt.yaml"
REGION="ap-south-1"

# Default parameters (you can override via CLI)
VPC_CIDR="10.200.123.0/24"
PUBLIC_SUBNET_CIDR="10.200.123.0/26"
PRIVATE_SUBNET_CIDR="10.200.123.64/26"
AZ=$(aws ec2 describe-availability-zones --region "$REGION" --query "AvailabilityZones[0].ZoneName" --output text)
DNS_SUPPORT="true"
DNS_HOSTNAMES="true"

# -------- Usage Help --------
usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  -s STACK_NAME           CloudFormation stack name (default: $STACK_NAME)"
  echo "  -f TEMPLATE_FILE        Path to the CFN template file (default: $TEMPLATE_FILE)"
  echo "  -r REGION               AWS Region (default: $REGION)"
  echo "  -v VPC_CIDR             VPC CIDR block (default: $VPC_CIDR)"
  echo "  -p PUBLIC_SUBNET_CIDR   Public subnet CIDR (default: $PUBLIC_SUBNET_CIDR)"
  echo "  -x PRIVATE_SUBNET_CIDR  Private subnet CIDR (default: $PRIVATE_SUBNET_CIDR)"
  echo "  -z AVAILABILITY_ZONE    Availability Zone (default: first AZ in region)"
  echo "  -h                      Show this help message"
  exit 1
}

# -------- Parse CLI Args --------
while getopts "s:f:r:v:p:x:z:h" opt; do
  case "$opt" in
    s) STACK_NAME="$OPTARG" ;;
    f) TEMPLATE_FILE="$OPTARG" ;;
    r) REGION="$OPTARG" ;;
    v) VPC_CIDR="$OPTARG" ;;
    p) PUBLIC_SUBNET_CIDR="$OPTARG" ;;
    x) PRIVATE_SUBNET_CIDR="$OPTARG" ;;
    z) AZ="$OPTARG" ;;
    h|*) usage ;;
  esac
done

# -------- Deploy CFN Stack --------
echo "Deploying stack '$STACK_NAME' in region '$REGION'..."

## https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --region "$REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    VpcCidr="$VPC_CIDR" \
    PublicSubnetCidr="$PUBLIC_SUBNET_CIDR" \
    PrivateSubnetCidr="$PRIVATE_SUBNET_CIDR" \
    AvailabilityZone="$AZ" \
    EnableDnsSupport="$DNS_SUPPORT" \
    EnableDnsHostnames="$DNS_HOSTNAMES"

echo "✅ Deployment complete."
