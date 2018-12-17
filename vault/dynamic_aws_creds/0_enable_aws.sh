# Expects the AWS environment variables:
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_DEFAULT_REGION
# These should have access to create IAM users and attach polices


vault secrets enable aws

vault write aws/config/root \
    access_key=${AWS_ACCESS_KEY_ID} \
    secret_key=${AWS_SECRET_ACCESS_KEY} \
    region=${AWS_DEFAULT_REGION}

vault write aws/config/lease \
  lease=2m \
  lease_max=24h

vault write aws/roles/dynamo-db-read-only \
  policy_arns="${DYNAMODB_READ_ONLY_ARN}" \
  credential_type=iam_user

vault read -format=json aws/creds/dynamo-db-read-only | jq -r '.data | to_entries | map("\(.key)=\(.value|tostring)")|.[]' | sed -e "s/access_key/export AWS_ACCESS_KEY_ID/" -e "s/secret_key/export AWS_SECRET_ACCESS_KEY/" | grep -v token

