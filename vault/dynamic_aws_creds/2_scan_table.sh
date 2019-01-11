. env.sh
. .dynamic_creds

pe "aws dynamodb scan --table-name=${DYNAMO_BEERS_TABLE_NAME} | jq .Items[0]"
pe "aws dynamodb scan --table-name=${DYNAMO_BEERS_TABLE_NAME} | jq .Items[1]"
pe "aws dynamodb scan --table-name=${DYNAMO_BEERS_TABLE_NAME} | jq .Items[2]"
