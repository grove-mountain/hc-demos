# Dynamic AWS Creds

The main point of this demo is to highlight the ability to create dynamic AWS creds.   This will demonstrate how to create time bound access to AWS resources.  

There will be several examples contained in here mostly due to specific customer asks.  


## Terraform 

There are terraform manifests to create a basic DynamoDB table and IAM policies to be used by the AWS Secrets engine.   You'll need terraform installed of course.

DO NOT PUT YOUR KEYS IN VERSION CONTROL! (You can't merge them anyway, but still, don't do this).

```
cd dynamodb_access/terraform
terraform init
terraform plan # Make sure everything is kosher
terraform apply
```

## Usage

Once terraform has created your IAM policies and DynamoDB just run the numbered scripts in order
