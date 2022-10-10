GCI_Remove_Bucket()
{
  GCI_Test_Bucket
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Bucket [Absent]"
  else
    gsutil rm -r gs://$Bucket_Name \
    >> log.txt 2>&1

    GCI_Test_Bucket
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Bucket [Removed]"
    fi
  fi
}


GCI_Remove_IPAddress()
{
  GCI_Test_IPAddress
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Adress [Absent]"
  else
    gcloud compute addresses delete $LB_Address_Name \
      --global \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_IPAddress
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Adress [Removed]"
    fi
  fi
}

GCI_Remove_VPCNetwork()
{
  GCI_Test_VPCNetwork
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) VPC [Absent]"
  else
    gcloud compute networks delete $VPC_Name \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_VPCNetwork
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) VPC [Removed]"
    fi
  fi
}

GCI_Remove_VPCFirewallRules()
{
  GCI_Test_VPCFirewallRules
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) VPC Firewall rules [Absent]"
  else
    gcloud compute firewall-rules delete $VPC_FirewallRule_Name \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_VPCFirewallRules
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) VPC Firewall rules [Removed]"
    fi
  fi
}

GCI_Remove_VPCNetworkSubnet()
{
  GCI_Test_VPCNetworkSubnet
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) VPC Subnet [Absent]"
  else
    gcloud compute networks subnets delete $VPC_Subnet_Name \
      --region=$GCloud_Region \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_VPCNetworkSubnet
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) VPC Subnet [Removed]"
    fi
  fi
}

GCI_Remove_DNSZone()
{
  GCI_Test_DNSZone
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) DNS Zone [Absent]"
  else
    gcloud dns managed-zones delete $DNS_Zone_EntityName \
    --quiet

    GCI_Test_DNSZone
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) DNS Zone [Removed]"
    fi
  fi
}

GCI_Remove_DNSRecords()
{
  GCI_Test_DNSRecords
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) DNS Record [Absent]"
  else
    gcloud dns record-sets delete $DNS_Webserver_record. \
      --type=$DNS_Webserver_recordtype \
      --zone=$DNS_Zone_EntityName \
      --quiet

    GCI_Test_DNSRecords
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) DNS Record [Removed]"
    fi
  fi
}

GCI_Remove_InstanceTemplate()
{
  GCI_Test_InstanceTemplate
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Instance Template [Absent]"
  else
    gcloud compute instance-templates delete $InstanceTemplate_Name \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_InstanceTemplate
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Instance Template [Removed]"
    fi
  fi
}

GCI_Remove_APIInstanceTemplate()
{
  GCI_Test_APIInstanceTemplate
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) API Instance Template [Absent]"
  else
    gcloud compute instance-templates delete $APIInstanceTemplate_Name \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_APIInstanceTemplate
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) API Instance Template [Removed]"
    fi
  fi
}

GCI_Remove_SQLInstance()
{
  GCI_Test_SQLInstance
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) SQL Instance [Absent]"
  else
    gcloud sql instances delete $SQLInstance_Name \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_SQLInstance
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) SQL Instance [Removed]"
    fi
  fi
}

GCI_Remove_MIG()
{
  GCI_Test_MIG
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Managed Instance Group [Absent]"
  else
    gcloud compute instance-groups managed delete $MIG_Name \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_MIG
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Managed Instance Group [Removed]"
    fi
  fi
}

GCI_Remove_APIMIG()
{
  GCI_Test_APIMIG
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) API Managed Instance Group [Absent]"
  else
    gcloud compute instance-groups managed delete $API_MIG_Name \
      --zone $GCloud_Zone \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_APIMIG
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) API Managed Instance Group [Removed]"
    fi
  fi
}
GCI_Remove_HTTPHealthCheck()
{
  GCI_Test_HTTPHealthCheck
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) HTTP Health Check [Absent]"
  else
    gcloud compute health-checks delete $LB_HealthCheck_Name \
      --global \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_HTTPHealthCheck
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) HTTP Health Check [Removed]"
    fi
  fi
  # cloud compute firewall-rules delete fw-allow-health-check
}

GCI_Remove_TCPHealthCheck()
{
  GCI_Test_TCPHealthCheck
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) API HTTP Health Check [Absent]"
  else
    gcloud compute health-checks delete $LB_API_HealthCheck_Name \
      --global \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_TCPHealthCheck
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) API HTTP Health Check [Removed]"
    fi
  fi
}

GCI_Remove_BackendService()
{
  GCI_Test_BackendService
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) MVC Backend Service [Absent]"
  else
    gcloud compute backend-services delete $LB_BackendService_Name \
    --global \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_BackendService
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) MVC Backend Service [Removed]"
    fi
  fi
}

GCI_Remove_APIBackendService()
{
  GCI_Test_APIBackendService
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) API Backend Service [Absent]"
  else
    gcloud compute backend-services delete $LB_API_BackendService_Name \
    --global \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_APIBackendService
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) API Backend Service [Removed]"
    fi
  fi
}

GCI_Remove_URLMapping()
{
  GCI_Test_URLMapping
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) URL Mappings [Absent]"
  else
    gcloud compute url-maps delete $LB_URLMap_Name \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_URLMapping
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) URL Mappings [Removed]"
    fi
  fi
}

GCI_Remove_SSLCertificate()
{
  GCI_Test_SSLCertificate
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) SSL Certificate [Absent]"
  else
    gcloud compute ssl-certificates delete $LB_HTTPS_CertName \
    --global \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_SSLCertificate
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) SSL Certificate [Removed]"
    fi
  fi

}

GCI_Remove_HTTPSProxy()
{
  GCI_Test_HTTPSProxy
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) HTTPS Proxy [Absent]"
  else
    gcloud compute target-https-proxies delete $LB_ProxyName \
    --quiet \
    >> log.txt 2>&1

    GCI_Test_HTTPSProxy
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) HTTPS Proxy [Removed]"
    fi
  fi
}

GCI_Remove_ForwardingRules()
{
  GCI_Test_ForwardingRules
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Forwarding Rules [Absent]"
  else
    gcloud compute forwarding-rules delete $LB_ForwardingRule_Name \
      --global \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_ForwardingRules
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Forwarding Rules [Removed]"
    fi
  fi
}

GCI_Remove_Redis()
{
  GCI_Test_Redis
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) Redis [Absent]"
  else
    gcloud redis instances delete \
    --region $GCloud_Region \
    $Redis_Name

    GCI_Test_Redis
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) Redis [Removed]"
    fi
  fi
}

GCI_Remove_HTTPRedirect()
{
  GCI_Test_HTTPRedirect
  if [[ $? -eq 0 ]]; then
    echo "$(PrintTimestamp) HTTP Redirect [Absent]"
  else
    gcloud compute forwarding-rules delete $LB_HTTPtoHTTPS_ForwardingRule_Name\
      --global \
      --quiet \
      >> log.txt 2>&1

    gcloud compute target-https-proxies delete $LB_HTTPtoHTTPS_Proxy_Name\
      --quiet \
      >> log.txt 2>&1

    gcloud compute url-maps delete $LB_HTTPtoHTTPS_URLMap_Name \
      --quiet \
      >> log.txt 2>&1

    GCI_Test_HTTPRedirect
    if [[ $? -eq 0 ]]; then
      echo "$(PrintTimestamp) HTTP Redirect [Removed]"
    fi
  fi
}
