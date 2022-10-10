GCI_Create_Bucket()
{
  GCI_Test_Bucket
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Bucket %-20s  [\e[32mPresent\e[0m] \n"
  else
    gsutil mb -p $GCloud_Project -l $GCloud_Region  gs://$Bucket_Name >> log.txt 2>&1

    gsutil cp files/MVC/app.service gs://$Bucket_Name/MVC/
    gsutil cp files/MVC/deploy_app.sh gs://$Bucket_Name/MVC/

    gsutil cp files/GCloud/Metadata.sh gs://$Bucket_Name/GCloud/Metadata.sh

    gsutil cp files/API/appapi.service gs://$Bucket_Name/API/
    gsutil cp files/API/deploy_api.sh gs://$Bucket_Name/API/

    GCI_Test_Bucket
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Bucket %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_VPCNetwork()
{
  GCI_Test_VPCNetwork
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) VPC Network %-20s  [\e[32mPresent\e[0m] \n"
  else
    gcloud compute networks create $VPC_Name \
      --project=$GCloud_Project \
      --subnet-mode=$VPC_SubnetMode \
      --mtu=$VPC_MTU \
      --bgp-routing-mode=$VPC_BGPRoutingMode \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_VPCNetwork
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) VPC Network %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_VPCNetworkSubnet()
{
  GCI_Test_VPCNetworkSubnet
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) VPC Subnet %-20s  [\e[32mPresent\e[0m] \n"
  else
    gcloud compute networks subnets create $VPC_Subnet_Name \
      --project=$GCloud_Project \
      --range=$VPC_Subnet_Range \
      --stack-type=$VPC_Subnet_StackType \
      --network=$VPC_Name \
      --region=$GCloud_Region \
      --enable-private-ip-google-access \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_VPCNetworkSubnet
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) VPC Subnet %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_VPCFirewallRules()
{
  GCI_Test_VPCFirewallRules
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) VPC Firewall rules %-20s  [\e[32mPresent\e[0m] \n"
  else
    gcloud compute firewall-rules create $VPC_FirewallRule_Name \
    --network $VPC_Name \
    --allow $VPC_FirewallRule_Allow \
    --source-ranges $VPC_Subnet_Range \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_VPCFirewallRules
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) VPC Firewall rules %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_IPAddress()
{
  GCI_Test_IPAddress
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Address %-20s  [\e[32mPresent\e[0m] \n"
  else
    gcloud compute addresses create $LB_Address_Name \
  	--project=$GCloud_Project \
    --global \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_IPAddress
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Address %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_DNSZone()
{
  GCI_Test_DNSZone
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) DNS Zone - $DNS_Zone_DomainName %-20s  [\e[32mPresent\e[0m] \n"
  else
    gcloud dns --project=integratieproject-1-341014 managed-zones create $DNS_Zone_EntityName \
      --dns-name $DNS_Zone_DomainName \
      --description $DNS_Zone_Description \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_DNSZone
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) DNS Zone - $DNS_Zone_DomainName %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_DNSRecords()
{
  GCI_Test_DNSRecords
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) DNS Record - $DNS_Webserver_record %-20s  [\e[32mPresent\e[0m] \n"
  else
    ip_address=$(gcloud compute addresses list --global | grep -w $LB_Address_Name | awk '{print $2}')

    gcloud dns record-sets create $DNS_Webserver_record. \
      --project=$GCloud_Project \
      --type=$DNS_Webserver_recordtype \
      --zone=$DNS_Zone_EntityName \
      --rrdatas=$ip_address \
      --ttl=$DNS_Webserver_ttl \
      >> log.txt 2>&1

    GCI_Test_DNSRecords
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) DNS Zone - $DNS_Webserver_record %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_SQLInstance()
{
  GCI_Test_SQLInstance
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) SQL Instance %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud sql instances create $SQLInstance_Name \
    --network=$VPC_Name \
    --database-version $SQLInstance_DatabaseType \
    --storage-size $SQLInstance_Size \
    --storage-auto-increase \
    --root-password $SQLInstance_Password \
    --storage-type $SQLInstance_StorageType \
    --tier $SQLInstance_Tier \
    --region $GCloud_Region \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_SQLInstance
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) SQL Instance %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_Redis()
{
  GCI_Test_Redis
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Redis %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud redis instances create $Redis_Name \
      --size=$Redis_Size \
      --region=$GCloud_Region \
      --network=$VPC_Name \
      --redis-version=$Redis_Version \
      --quiet \
      >> log.txt 2>&1
    GCI_Test_Redis
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Redis %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_SSLCertificate()
{
  GCI_Test_SSLCertificate
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) SSL Certificate %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute ssl-certificates create $LB_SSL_CertName \
      --domains $LB_SSL_Domain \
      --global \
      >> log.txt 2>&1

    GCI_Test_SSLCertificate
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) SSL Certificate %-20s [\e[5m\e[93mChanged\e[0m] \n"
      echo "NOTE: It can take a while before the cert is activated at the provider"
    fi
  fi
}

GCI_Create_InstanceTemplate()
{
  GCI_Test_InstanceTemplate
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Instance Template %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute instance-templates create $InstanceTemplate_Name \
    --network=$VPC_Name \
    --subnet=$VPC_Subnet_Name \
    --project=$GCloud_Project \
    --region=$GCloud_Region \
    --machine-type=$CloudCompute_MachineType \
    --no-restart-on-failure \
    --maintenance-policy=$CloudCompute_MaintenancePolicy \
    --provisioning-model=$CloudCompute_ProvisioningModel \
    --service-account=$CloudCompute_ServiceAccount \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=$CloudCompute_Tags \
    --create-disk=$CloudComputeInstance_DiskSettings \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --reservation-affinity=$CloudCompute_ReservationAffinity \
    --metadata-from-file startup-script=files/MVC/cloudapp_deploy.sh \
    >> log.txt 2>&1

    GCI_Test_InstanceTemplate
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Instance Template %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_APIInstanceTemplate()
{
  GCI_Test_APIInstanceTemplate
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) API Instance Template %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute instance-templates create $APIInstanceTemplate_Name \
    --network=$VPC_Name \
    --subnet=$VPC_Subnet_Name \
    --project=$GCloud_Project \
    --region=$GCloud_Region \
    --machine-type=$CloudCompute_MachineType \
    --no-restart-on-failure \
    --maintenance-policy=$CloudCompute_MaintenancePolicy \
    --provisioning-model=$CloudCompute_ProvisioningModel \
    --service-account=$CloudCompute_ServiceAccount \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=$CloudCompute_Tags \
    --create-disk=$APICloudComputeInstance_DiskSettings \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --reservation-affinity=$CloudCompute_ReservationAffinity \
    --metadata-from-file startup-script=files/API/cloudapi_deploy.sh \
    >> log.txt 2>&1

    GCI_Test_APIInstanceTemplate
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) API Instance Template %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_MIG()
{
  GCI_Test_MIG
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Managed Instance Group %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute instance-groups managed create $MIG_Name \
      --template $InstanceTemplate_Name \
      --size $MIG_Size \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    gcloud compute instance-groups set-named-ports $MIG_Name \
      --named-ports=$LB_HealthCheck_Name:$LB_HealthCheck_Port \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    gcloud compute instance-groups managed set-autoscaling $MIG_Name \
      --zone=$GCloud_Zone \
      --min-num-replicas $MIG_Autoscaling_MinSize \
      --max-num-replicas $MIG_Autoscaling_MaxSize \
      --target-cpu-utilization $MIG_Autoscaling_CPUUtil \
      --cool-down-period $MIG_Autoscaling_CooldownPeriod \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_MIG
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Managed Instance Group %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_APIMIG()
{
  GCI_Test_APIMIG
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) API Managed Instance Group %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute instance-groups managed create $API_MIG_Name \
      --template $APIInstanceTemplate_Name \
      --size $API_MIG_Size \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    gcloud compute instance-groups set-named-ports $API_MIG_Name \
      --named-ports=$LB_HealthCheck_Name:$LB_HealthCheck_Port \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    gcloud compute instance-groups managed set-autoscaling $API_MIG_Name \
      --zone=$GCloud_Zone \
      --min-num-replicas $API_MIG_Autoscaling_MinSize \
      --max-num-replicas $API_MIG_Autoscaling_MaxSize \
      --target-cpu-utilization $API_MIG_Autoscaling_CPUUtil \
      --cool-down-period $API_MIG_Autoscaling_CooldownPeriod \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_APIMIG
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) API Managed Instance Group %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_HTTPHealthCheck()
{
  GCI_Test_HTTPHealthCheck
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) HTTP Healthcheck - MVC %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute health-checks create http $LB_HealthCheck_Name \
      --port $LB_HealthCheck_Port \
      >> log.txt 2>&1

    gcloud compute firewall-rules create fw-allow-health-check \
      --network $VPC_Name \
      --action=allow \
      --direction=ingress \
      --source-ranges 130.211.0.0/22,35.191.0.0/16,209.85.204.0/22,209.85.152.0/22 \
      --target-tags allow-health-check \
      --rules tcp:$LB_HealthCheck_Port \
      >> log.txt 2>&1

    GCI_Test_HTTPHealthCheck
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) HTTP Healthcheck - MVC %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_TCPHealthCheck()
{
  GCI_Test_TCPHealthCheck
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) API HTTP Healthcheck %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute health-checks create http $LB_API_HealthCheck_Name \
      --port $LB_API_HealthCheck_Port \
      --request-path $LB_API_HealthCheck_Path \
      >> log.txt 2>&1

    gcloud compute firewall-rules create fw-api-allow-health-check \
      --network $VPC_Name \
      --action=allow \
      --direction=ingress \
      --source-ranges 130.211.0.0/22,35.191.0.0/16,209.85.204.0/22,209.85.152.0/22 \
      --target-tags allow-health-check \
      --rules tcp:$LB_HealthCheck_Port \
      >> log.txt 2>&1

    GCI_Test_TCPHealthCheck
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) API HTTP Healthcheck %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}


GCI_Create_BackendService()
{
  GCI_Test_BackendService
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Backend Service %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute backend-services create $LB_BackendService_Name \
      --network $VPC_Name \
      --protocol HTTP \
      --port-name $LB_HealthCheck_Name \
      --health-checks $LB_HealthCheck_Name \
      --global \
      >> log.txt 2>&1

    # Step 4.1 - Add MIG to backend service
    gcloud compute backend-services add-backend $LB_BackendService_Name \
      --instance-group $MIG_Name \
      --instance-group-zone $GCloud_Zone \
      --global \
      >> log.txt 2>&1

    GCI_Test_BackendService
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Backend Service %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_APIBackendService()
{
  GCI_Test_APIBackendService
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) API Backend Service %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute backend-services create $LB_API_BackendService_Name \
      --network $VPC_Name \
      --protocol HTTP \
      --port-name $LB_HealthCheck_Name \
      --health-checks $LB_API_HealthCheck_Name \
      --global \
      >> log.txt 2>&1

    # Step 4.1 - Add MIG to backend service
    gcloud compute backend-services add-backend $LB_API_BackendService_Name \
      --instance-group $API_MIG_Name \
      --instance-group-zone $GCloud_Zone \
      --global \
      >> log.txt 2>&1

    GCI_Test_APIBackendService
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) API Backend Service %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_URLMapping()
{
  GCI_Test_URLMapping
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) URL Mapping %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute url-maps create $LB_URLMap_Name \
      --default-service $LB_BackendService_Name \
      >> log.txt 2>&1

    gcloud compute url-maps add-path-matcher $LB_URLMap_Name \
        --default-service=$LB_BackendService_Name \
        --path-matcher-name=$LB_API_PathMatcher_Name \
        --path-rules=$LB_API_PathRules

    GCI_Test_URLMapping
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) URL Mapping %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_HTTPSProxy()
{
  GCI_Test_HTTPSProxy
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) HTTPS Proxy %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute target-https-proxies create $LB_ProxyName \
      --url-map $LB_URLMap_Name \
      --ssl-certificates $LB_SSL_CertName \
      >> log.txt 2>&1

    GCI_Test_HTTPSProxy
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) HTTPS Proxy %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_ForwardingRules()
{
  GCI_Test_ForwardingRules
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) Forwarding Rules %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute forwarding-rules create $LB_ForwardingRule_Name \
      --address=$LB_Address_Name \
      --global \
      --target-https-proxy=$LB_ProxyName \
      --ports=$LB_ProxyPort \
      >> log.txt 2>&1

    GCI_Test_ForwardingRules
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) Forwarding Rules %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}

GCI_Create_HTTPRedirect()
{
  GCI_Test_HTTPRedirect
  if [[ $? -eq 1 ]]; then
    printf "$(PrintTimestamp) HTTP to HTTPS Redirect %-20s [\e[32mPresent\e[0m] \n"
  else
    gcloud compute url-maps import $LB_HTTPtoHTTPS_URLMap_Name \
    --source $LB_HTTPtoHTTPS_URLMap_SourceFile \
    --global \
    --quiet \
    >> log.txt 2>&1

    gcloud compute target-http-proxies create $LB_HTTPtoHTTPS_Proxy_Name \
    --url-map=$LB_HTTPtoHTTPS_URLMap_Name \
    --global \
    --quiet \
    >> log.txt 2>&1

    gcloud compute forwarding-rules create $LB_HTTPtoHTTPS_ForwardingRule_Name \
    --load-balancing-scheme=$LB_HTTPtoHTTPS_ForwardingRule_LBScheme \
    --network-tier=$LB_HTTPtoHTTPS_ForwardingRule_NetworkTier \
    --address=$LB_Address_Name\
    --global \
    --target-http-proxy=$LB_HTTPtoHTTPS_Proxy_Name \
    --ports=$LB_HTTPtoHTTPS_ForwardingRule_Ports \
    --quiet \
    >> log.txt 2>&1


    GCI_Test_HTTPRedirect
    if [[ $? -eq 1 ]]; then
      printf "$(PrintTimestamp) HTTP to HTTPS Redirect %-20s [\e[5m\e[93mChanged\e[0m] \n"
    fi
  fi
}
