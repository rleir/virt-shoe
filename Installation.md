# Installation

## Warning

When you are not actively installing systems, I recommend that you leave the installer disabled. An unintended installation would make for a bad day, and this could easily happen.

## Install the Borvo2 support server

The Borvo2 support server is the PXE boot server, so it serves Cobbler, and is the Puppet master. It can be a virtual server if desired. This page assumes you have Redhat, Fedora or Centos installed, but Ubuntu or other distros can be used without many changes.

Install packages using yum or dnf.
```
dnf install cobbler cobbler-web syslinux yum-utils pykickstart puppet activemq
```

Start Apache and Cobbler:
```
# systemctl enable httpd.service 
# systemctl enable cobblerd.service 
# systemctl start  httpd.service 
# systemctl start  cobblerd.service 
```

Configure Cobbler as shown here
   http://cobbler.github.io/manuals/quickstart/

In cobbler/settings, set default_password_crypted as directed.

In cobbler/settings, set theseeeeeeeeeeeeeeeeeeeeeeeezzzz
```
## virt-shoe
## this will be the hostname of the newly installed server
hostname: server75.example.net
hostIP: 10.100.2.75
```

And accept the ks log:
```
## virt-shoe
anamon_enabled: 1
```

Give the name or IP of the Cobbler server instead of localhost:
```
##server: 127.0.0.1
server: Borvo2
```

Give the name or IP of the PXE boot server instead of localhost:
```
##next_server: 127.0.0.1
next_server: Borvo2
```

Configure the Cobbler web UI as shown here
   http://cobbler.github.io/manuals/2.6.0/5_-_Web_Interface.html

If you have Selinux in enforcing mode, you need to look at:
   https://github.com/cobbler/cobbler/wiki/Selinux

Or disable Selinux:
```
$ sudo setenforce 0
$ getenforce
Permissive
```

Compare the files in virt-shoe/etc with the default etc files, and configure as needed for your network names and IP's.

Also, in activemq/activemq.xml set the password
```
        <authenticationUser username="mcollective" password="something" groups="mcollective,everyone"/>
        <authenticationUser username="admin" password="secret" groups="mcollective,admins,everyone"/>
```

Check for configuration problems:
```
# cobbler check
```

We need a mirror of Fedora, Redhat, or Centos (to reduce latency, and for version control). Set up the mirror in 
```
/var/www/cobbler/repo_mirror/Centosbase6.3/
/var/www/cobbler/repo_mirror/CentosUpdates/
```
Install /var/www/html/CentOS-Base.repo .
Make soft links to the above dirs (this will be scripted shortly)


## Extra Reading

Deploy Fedora over a network https://www.gadgetdaily.xyz/deploy-fedora-over-a-network/

Provisioning http://www.cyberciti.biz/tips/server-provisioning-software.html

