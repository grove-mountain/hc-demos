# Expects the AWS environment variables:
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# AWS_DEFAULT_REGION
# These should have access to create IAM users and attach polices
. env.sh


pe "vault secrets enable aws"
cat << EOF
vault write aws/config/root
    access_key=\${AWS_ACCESS_KEY_ID}
    secret_key=\${AWS_SECRET_ACCESS_KEY}
    region=\${AWS_DEFAULT_REGION}
EOF
p

vault write aws/config/root \
    access_key=${AWS_ACCESS_KEY_ID} \
    secret_key=${AWS_SECRET_ACCESS_KEY} \
    region=${AWS_DEFAULT_REGION}

pe "vault write aws/config/lease lease=${TTL} lease_max=${MAX_TTL}"

cat << EOF
vault write aws/roles/dynamo-db-read-only
  policy_arns="${DYNAMODB_READ_ONLY_ARN}"
  credential_type=iam_user
EOF
p

vault write aws/roles/dynamo-db-read-only \
  policy_arns="${DYNAMODB_READ_ONLY_ARN}" \
  credential_type=iam_user
