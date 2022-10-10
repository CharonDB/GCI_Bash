#!/usr/bin/bash
gsutil cp gs://app-deployment/GCloud/Metadata.sh .
gsutil cp gs://app-deployment/API/app.service /etc/systemd/system/
gsutil cp gs://aoo-deployment/API/deploy_api.sh .
bash deploy_api.sh
