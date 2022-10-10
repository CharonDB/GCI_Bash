#!/usr/bin/bash
Gitlab_Token="gitlabtokenhere"
Gitlab_ProjectID="12345678"
NFS_Share_Address="12.34.56.78"

dnf install firewalld nfs-utils unzip npm -y

systemctl start firewalld
systemctl enable firewalld
firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload

## Copy bullshit
curl -L --header "PRIVATE-TOKEN: $Gitlab_Token" "https://gitlab.com/api/v4/projects/$Gitlab_ProjectID/jobs/artifacts/master/download?job=Release" --output app.zip
unzip app.zip
sudo mkdir /usr/bin/app
sudo mkdir /usr/bin/app/wwwroot/Files -p
sudo mount -t nfs $NFS_Share_Address:/var/app/files /usr/bin/app/wwwroot/Files
mv UI.MVC/bin/Release/net6.0/linux-x64/* /usr/bin/app/

cd /usr/bin/app/ClientApp
npm i
npm run build

# SELinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
chcon -t unconfined_exec_t /usr/bin/app/UI.MVC
sudo setenforce 0

# Application
sudo systemctl daemon-reload
sudo systemctl enable app
sudo systemctl start app

#curl localhost:8080

#semodule -X 300 -i app.pp

#ausearch -c '.NET ThreadPool' --raw | audit2allow -M NETThreadPool
#semodule -X 300 -i NETThreadPool.pp
