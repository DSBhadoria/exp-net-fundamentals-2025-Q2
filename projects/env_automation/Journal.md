## VPC Settings

A VPC setup on AWS requires the below specifications -

- VPC IPv4 CIDR Block: 100.200.123.0/24
- IPv6 CIDR Block: None
- Numbe of AZs: 1
- Number of Public subnet: 1
- Number of Private subnet: 1
- NAT GATEWAYS: None
- VPC Endpoints: None
- DNS Options: Enable DNS Hostnames, Enable DNS Resolution

## Generated and Review CFN Template

A CFN Template used here is generated using the ChatGPT.
I've compared the templates created by this way, where it is leveraging the in-house LLM model customization, against the one suggested by the ChatGPT and I found this as an more generic.
You can get it tweaked based on the input provided with different AI LLM models present widely in the market.

## Generate Deploy Script

Used ChatGPT to generate a bash script 'bin/deploy_vpc_stack.sh', customized for all OS platforms.

## Visualization with Infrastructure Composer

![](assets/aws_infra_composer.png)

## Installaing AWS CLI

For deploying using the AWS CLI, you need to install the AWS CLI.

Checkout the AWS Documemtation for the installation steps -
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## Deployed AWS Resource

Resource map of the VPC deployed with CFN -

![](assets/aws_cfn_stack.png)

![](assets/aws_vpc_resource_map.png)
