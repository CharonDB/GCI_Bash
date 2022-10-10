sudo dnf install nfs-utils
sudo mkdir /var/app/files -p
sudo chown -R nobody:nobody /var/app/files
echo '/var/app/files *(rw,sync,no_subtree_check,insecure)' > /etc/exports
exportfs -rav
systemctl enable --now nfs-server
sudo chmod -R 777 /var/app/files/
