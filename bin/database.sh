#!/bin/bash
set -eu

source configs/config
source bin/usage.sh

create() {
  echo "Creating DynamoDB table"
  aws dynamodb create-table \
	  --table-name "$TABLE_NAME" \
	  --attribute-definitions \
		AttributeName=Id,AttributeType=S \
	  --key-schema \
		AttributeName=Id,KeyType=HASH \
	  --provisioned-throughput \
		ReadCapacityUnits=1,WriteCapacityUnits=1 \
	  --table-class STANDARD
}

delete() {
  echo "Deleting DynamoDB table"
  aws dynamodb delete-table --table-name "$TABLE_NAME"
}


main "$@"
