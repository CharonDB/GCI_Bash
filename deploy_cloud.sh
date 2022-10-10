#!/usr/bin/bash
source variables.sh
source functions.sh
source Scripts/Test.sh
source Scripts/Create.sh
source Scripts/Delete.sh

remove="0"
removesslcert="0"
removedb="0"
nodb="0"
removevnet="0"
removedns="0"
removeredis="0"

while [ -n "$1" ]
do
case "$1" in
--no-db ) nodb="1" ;;
-d      ) remove="1" ;;
--delete) remove="1" ;;
-h      ) PrintHelp; exit 0 ;;
--help  ) PrintHelp; exit 0 ;;
--remove-database ) removedb="1" ;;
--remove-sslcertificate ) removesslcert="1" ;;
--remove-virtual-network ) removevnet="1" ;;
--remove-dns ) removedns="1" ;;
--remove-redis ) removeredis="1" ;;
*) echo "$1 is not an valid option"; exit 0;;
esac
shift
done


if (( "$remove" == "0" )); then
  GCI_Create_Bucket
  GCI_Create_IPAddress
  GCI_Create_VPCNetwork
  GCI_Create_VPCNetworkSubnet
  GCI_Create_VPCFirewallRules
  GCI_Create_IPAddress
  GCI_Create_DNSZone
  GCI_Create_DNSRecords
  if [[ "$nodb" == "1" ]]; then
    GCI_Create_SQLInstance
  fi
  GCI_Create_Redis
  GCI_Create_SSLCertificate
  GCI_Create_InstanceTemplate
  GCI_Create_APIInstanceTemplate
  GCI_Create_MIG
  GCI_Create_APIMIG
  GCI_Create_HTTPHealthCheck
  GCI_Create_TCPHealthCheck
  GCI_Create_BackendService
  GCI_Create_APIBackendService
  GCI_Create_URLMapping
  GCI_Create_HTTPSProxy
  GCI_Create_ForwardingRules
  GCI_Create_HTTPRedirect

else
  GCI_Remove_HTTPRedirect
  GCI_Remove_ForwardingRules
  GCI_Remove_HTTPSProxy
  GCI_Remove_URLMapping
  GCI_Remove_APIBackendService
  GCI_Remove_BackendService
  GCI_Remove_TCPHealthCheck
  GCI_Remove_HTTPHealthCheck
  GCI_Remove_APIMIG
  GCI_Remove_MIG
  GCI_Remove_APIInstanceTemplate
  GCI_Remove_InstanceTemplate

  if [[ "$removesslcert" == "1" ]]; then
    GCI_Remove_SSLCertificate
  fi

  if [[ "$removeredis" == "1" ]]; then
    GCI_Remove_Redis
  fi

  if [[ "$removedb" == "1" ]]; then
    if [[ "$nodb" == "0" ]]; then
      GCI_Remove_SQLInstance
    fi
  fi

  GCI_Remove_DNSRecords

  if [[ "$removedns" == "1" ]]; then
    GCI_Remove_DNSZone
  fi

  GCI_Remove_IPAddress

  if [[ "$removevnet" == "1" ]]; then
    GCI_Remove_VPCFirewallRules
    GCI_Remove_VPCNetworkSubnet
    GCI_Remove_VPCNetwork
  fi
  GCI_Remove_Bucket
fi
