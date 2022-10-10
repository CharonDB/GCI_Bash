#!/usr/bin/bash
Gitlab_Token="gitlabtokenhere"
Gitlab_ProjectID="12345678"


dnf install firewalld unzip -y

#Environment Variables
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --add-port=8080/tcp --permanent

## if HTTPs is enabled
# firewall-cmd --add-service=https --permanent

firewall-cmd --reload

## Copy bullshit - zeker de MV veranderen -> eerste param
curl -L --header "PRIVATE-TOKEN: $Gitlab_Token" "https://gitlab.com/api/v4/projects/$Gitlab_ProjectID/jobs/artifacts/master/download?job=APIRelease" --output app.zip
unzip app.zip
sudo mkdir /usr/bin/app
mv RESTApi/bin/Release/net6.0/linux-x64/* /usr/bin/app/

# SELinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
chcon -t unconfined_exec_t /usr/bin/app/RESTApi
sudo setenforce 0

# Application
sudo systemctl daemon-reload
sudo systemctl enable appapi
sudo systemctl start appapi

#curl localhost:8080

#semodule -X 300 -i app.pp

#ausearch -c '.NET ThreadPool' --raw | audit2allow -M NETThreadPool
#semodule -X 300 -i NETThreadPool.pp
