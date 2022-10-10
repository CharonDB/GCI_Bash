#!/usr/bin/bash
gsutil cp gs://app-deployment/GCloud/Metadata.sh .
gsutil cp gs://app-deployment/MVC/app.service /etc/systemd/system/
gsutil cp gs://app-deployment/MVC/deploy_app.sh .
bash deploy_app.sh
