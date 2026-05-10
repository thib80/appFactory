#!/usr/bin/env bash
set -euo pipefail

cfg() { grep "^$1:" config.yaml | awk '{print $2}'; }

SERVICE_NAME=$(cfg service_name)
PROJECT_ID=$(cfg project_id)
REGION=$(cfg region)

echo "Deploying '${SERVICE_NAME}' to project '${PROJECT_ID}' in '${REGION}'"

gcloud builds submit \
  --config cloudbuild.yaml \
  --project "${PROJECT_ID}" \
  --substitutions "_SERVICE_NAME=${SERVICE_NAME},_REGION=${REGION}"
