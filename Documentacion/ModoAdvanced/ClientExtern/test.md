systemctl enable NetworkManager-wait-online.service
2  systemctl stop firewalld.service
3  systemctl disable firewalld.service
4  systemctl disable sshd.service
5  dnf -y install vim gvim mc
6  sed -i -e s,'SELINUX=enforcing','SELINUX=permissive', /etc/selinux/config
7  dnf -y install  krb5-devel krb5-workstation pam_mount
8  authconfig-tui
9  cd /tmp
10  curl ftp://ftp/pub/deploy.sh | bash
11  tar -C / -xvzf config.tgz
12  systemctl enable nfs-secure.service
13  systemctl restart nfs-secure.service
14  mkdir /home/groups
15  vim /etc/fstab
16  mount -a
