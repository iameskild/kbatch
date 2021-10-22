#!/usr/bin/env bash
set -eu

url=$(curl -s -u admin:${ADMIN_PASSWORD} -X POST -H "Content-Type: multipart/form-data" -F "file=@script.sh" http://localhost:8050/uploads/ | jq -r .url)
echo "url: ${url}"

data=$(cat data.json | jq '. + {"upload": "'${url}'", "env": {"SAS_TOKEN": "'${SAS_TOKEN}'"}}')

echo ${data}

curl -u admin:${ADMIN_PASSWORD} \
    -X POST \
    -H "Content-Type: application/json" \
    --data "${data}" \
    http://localhost:8050/jobs/