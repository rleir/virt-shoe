# Installation

## Install the Borvo2 support server

The support server is the PXE boot server, so it serves Cobbler, and is the Puppet master. It can be a virtual server if desired. It needs to have Redhat, Fedora or Centos installed.

Install cobbler, puppet, and activemq using yum or dnf.

Compare the files in virt-shoe/etc with the default etc files, and configure as needed for your network names and IP's.

Also, in activemq/activemq.xml set the password
```
        <authenticationUser username="mcollective" password="something" groups="mcollective,everyone"/>
        <authenticationUser username="admin" password="secret" groups="mcollective,admins,everyone"/>
```

In cobbler/settings, set default_password_crypted as directed.


We need a mirror of Fedora, Redhat, or Centos (to reduce latency, and for version control). Set up the mirror in 
```
/var/www/cobbler/repo_mirror/Centosbase6.3/
/var/www/cobbler/repo_mirror/CentosUpdates/
```
Install /var/www/html/CentOS-Base.repo .
Make soft links to the above dirs (this will be scripted shortly)

