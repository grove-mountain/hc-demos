. env.sh

cat << EOF
vault read -format=json aws/creds/dynamo-db-read-only
  | jq -r '.data | to_entries | map("\(.key)=\(.value|tostring)")|.[]'
  | sed -e "s/access_key/export AWS_ACCESS_KEY_ID/"
    -e "s/secret_key/export AWS_SECRET_ACCESS_KEY/"
  | grep -v token | tee .dynamic_creds
EOF
p

vault read -format=json aws/creds/dynamo-db-read-only \
  | jq -r '.data | to_entries | map("\(.key)=\(.value|tostring)")|.[]' \
  | sed -e "s/access_key/export AWS_ACCESS_KEY_ID/" \
    -e "s/secret_key/export AWS_SECRET_ACCESS_KEY/" \
  | grep -v token | tee .dynamic_creds
