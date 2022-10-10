GCI_Test_Bucket()
{
  presence="$(gsutil ls -p $GCloud_Project  | grep 'gs://'$Bucket_Name'/' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}



GCI_Test_VPCNetwork()
{
  presence="$(gcloud compute networks list --filter $VPC_Name --quiet | grep $VPC_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_VPCNetworkSubnet()
{
  presence="$(gcloud compute networks subnets list --filter $VPC_Subnet_Name --quiet | grep $VPC_Subnet_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_VPCFirewallRules()
{
  presence="$(gcloud compute firewall-rules list --filter $VPC_FirewallRule_Name --quiet | grep $VPC_FirewallRule_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_IPAddress()
{
  presence="$(gcloud compute addresses list --filter $LB_Address_Name --quiet | grep $LB_Address_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_DNSZone()
{
  presence="$(gcloud dns managed-zones list --filter $DNS_Zone_EntityName --quiet | grep $DNS_Zone_EntityName' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_DNSRecords()
{
  presence="$(gcloud dns record-sets list --zone=$DNS_Zone_EntityName --quiet | grep $DNS_Webserver_record. -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_InstanceTemplate()
{
  presence="$(gcloud compute instance-templates list --filter $InstanceTemplate_Name --quiet | grep $InstanceTemplate_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_APIInstanceTemplate()
{
  presence="$(gcloud compute instance-templates list --filter $APIInstanceTemplate_Name --quiet | grep $APIInstanceTemplate_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_SQLInstance()
{
  presence="$(gcloud sql instances list --filter $SQLInstance_Name --quiet  | grep $SQLInstance_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_MIG()
{
  presence="$(gcloud compute instance-groups list --filter $MIG_Name --quiet | grep $MIG_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_APIMIG()
{
  presence="$(gcloud compute instance-groups list --filter $API_MIG_Name --quiet | grep $API_MIG_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_HTTPHealthCheck()
{
  presence="$(gcloud compute health-checks list --filter $LB_HealthCheck_Name --quiet | grep $LB_HealthCheck_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_TCPHealthCheck()
{
  presence="$(gcloud compute health-checks list --filter $LB_API_HealthCheck_Name --quiet | grep $LB_API_HealthCheck_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_BackendService()
{
  presence="$(gcloud compute backend-services list --filter $LB_BackendService_Name --quiet | grep $LB_BackendService_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_APIBackendService()
{
  presence="$(gcloud compute backend-services list --filter $LB_API_BackendService_Name --quiet | grep $LB_API_BackendService_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_URLMapping()
{
  presence="$(gcloud compute url-maps list --filter $LB_URLMap_Name --quiet | grep $LB_URLMap_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_SSLCertificate()
{
  presence="$(gcloud compute ssl-certificates list --filter $LB_SSL_CertName --global --quiet | grep $LB_SSL_CertName -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_HTTPSProxy()
{
  presence="$(gcloud compute target-https-proxies list --filter $LB_ProxyName --quiet | grep $LB_ProxyName -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_ForwardingRules()
{
  presence="$(gcloud compute forwarding-rules list --filter $LB_ForwardingRule_Name --quiet | grep $LB_ForwardingRule_Name -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_Redis()
{
  presence="$(gcloud redis instances list --region $GCloud_Region | grep $Redis_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}

GCI_Test_HTTPRedirect()
{
  presence="$(gcloud compute forwarding-rules list --filter $LB_HTTPtoHTTPS_ForwardingRule_Name --quiet | grep $LB_HTTPtoHTTPS_ForwardingRule_Name' ' -wc)"
  if [[ $presence == "1" ]]; then
    return 1
  else
    return 0
  fi
}
