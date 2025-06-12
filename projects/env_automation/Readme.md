## How to Deploy the Infrastructure


### Check your AWS Account

```sh
aws sts get-caller-identity
```

### Run Deploy Script
```sh
cd projects/env_automation
chmod u+x ./bin/deploy_vpc_stack.sh
./bin/deploy_vpv_stack.sh
```