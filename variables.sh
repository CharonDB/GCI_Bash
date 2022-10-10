#Generic cloud environment settings
GCloud_Project="project-app"
GCloud_Region="europe-west1"
GCloud_Zone="europe-west1-b"


Bucket_Name="deployment"


## VPC Specific stuff
#### Generic VPC settings
VPC_Name="vpc"
VPC_SubnetMode="custom"
VPC_MTU="1460"
VPC_BGPRoutingMode="regional"

#### VPC Subnet specific settings
VPC_Subnet_Name=""
VPC_Subnet_Range="10.0.0.0/9"
VPC_Subnet_StackType="IPV4_ONLY"

#### VPC Firewall rules
VPC_FirewallRule_Name="fw"
VPC_FirewallRule_Allow="tcp,udp,icmp"
VPC_Region=$GCloud_Region


## Redis specific stuff
Redis_Name=""
Redis_Size="1" # In gigabytes
Redis_Version="redis_6_0"

#### DNS settings

DNS_Zone_EntityName="domain"
DNS_Zone_DomainName="domain.com"
DNS_Zone_Description="applicationzone"
DNS_Zone_Visibility="public"
DNS_Zone_DNSSECState="off"

DNS_Webserver_record="www.$DNS_Zone_DomainName"
DNS_Webserver_recordtype="A"
DNS_Webserver_ttl="300"

## SQL Instance configuraiton
SQLInstance_Name="prod"
SQLInstance_DatabaseType="MYSQL_8_0"
SQLInstance_Size="10G"
SQLInstance_Password="password123"
SQLInstance_StorageType="SSD" # SSD or HDD
SQLInstance_Tier="db-g1-small"

##Cloudcompute instance template
InstanceTemplate_Name="instancetemplate"
APIInstanceTemplate_Name="api-instancetemplate"

APICloudComputeInstance_DiskSettings="auto-delete=yes,boot=yes,device-name=instancetemplate,image=projects/rocky-linux-cloud/global/images/rocky-linux-8-v20220406,mode=rw,size=20,type=pd-balanced"
CloudComputeInstance_NICSettings="network=$VPC_Subnet_Name,network-tier=PREMIUM,nic-type=VIRTIO_NET"
CloudComputeInstance_DiskSettings="auto-delete=yes,boot=yes,device-name=instancetemplate,image=projects/rocky-linux-cloud/global/images/rocky-linux-8-v20220406,mode=rw,size=20,type=pd-balanced"
CloudCompute_NIC_address=""
CloudCompute_NIC_Tier="PREMIUM"
CloudCompute_NIC_Subnet="default"
CloudCompute_Zone="europe-west1-b"
CloudCompute_MachineType="e2-small"
CloudCompute_MaintenancePolicy="MIGRATE"
CloudCompute_ProvisioningModel="STANDARD"
CloudCompute_Tags="allow-health-check,allow-network-lb-health-checks,default-allow-ssh,enable-guest-attributes"
CloudCompute_ReservationAffinity="any"
CloudCompute_DiskSettings="auto-delete=yes,boot=yes,device-name=rockylinux,image=projects/rocky-linux-cloud/global/images/rocky-linux-8-v20220406,mode=rw,size=20,type=projects/project-app/zones/us-central1-a/diskTypes/pd-balanced"
CloudCompute_ServiceAccount="012345678910-compute@developer.gserviceaccount.com"

## Managed instance group
MIG_Name="mig"
MIG_Size="2"
MIG_Autoscaling_MinSize="1"
MIG_Autoscaling_MaxSize="2"
MIG_Autoscaling_CPUUtil="0.80"
MIG_Autoscaling_CooldownPeriod="90"


API_MIG_Name="api-mig"
API_MIG_Size="2"
API_MIG_Autoscaling_MinSize="1"
API_MIG_Autoscaling_MaxSize="2"
API_MIG_Autoscaling_CPUUtil="0.80"
API_MIG_Autoscaling_CooldownPeriod="90"

## Loadbalancer specific settings
LB_Backend_Protocol="HTTP"
LB_Backend_PortName="http8080"
LB_Address_Name="lb-ip"
LB_HealthCheck_Name="healthcheck-8080"
LB_HealthCheck_Port="8080"
LB_Targetpool_Name="pool"
LB_BackendService_Name="backend"
LB_URLMap_Name="mapping"
LB_ForwardingRule_Name="content-rule"
LB_ProxyName="httpsproxy"
LB_ProxyPort="443"
LB_SSL_CertName="solo"
LB_SSL_Domain="domain.com"



LB_API_BackendService_Name="api-backend"
LB_API_HealthCheck_Name="api-healthcheck-8080"
LB_API_HealthCheck_Port="8080"
LB_API_HealthCheck_Path="/api/UserApi/"

LB_API_PathMatcher_Name="mymatcher"
LB_API_PathRules="/api/*=$LB_API_BackendService_Name"

## DNS specific settings
LB_DNS_Zone_EntityName="domain"

LB_HTTPtoHTTPS_URLMap_Name="map-http"
LB_HTTPtoHTTPS_URLMap_SourceFile="files/GCloud/map-http.yml"

LB_HTTPtoHTTPS_Proxy_Name="http-lb-proxy"

LB_HTTPtoHTTPS_ForwardingRule_LBScheme="EXTERNAL"
LB_HTTPtoHTTPS_ForwardingRule_Name="http-redirect"
LB_HTTPtoHTTPS_ForwardingRule_NetworkTier="PREMIUM"
LB_HTTPtoHTTPS_ForwardingRule_Ports="80"
