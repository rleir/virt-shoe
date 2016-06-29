# Installation

## Install the Borvo2 support server

The support server serves the PXE boot, Cobbler, and is the Puppet master. It can be a virtual server if desired. It needs to have Redhat, Fedora or Centos installed.

Install cobbler, puppet, activemq

Compare the files in virt-shoe/etc with the default etc files, and configure as needed for your network names and IP's.

Also, in activemq/activemq.xml set the password
```
        <authenticationUser username="mcollective" password="something" groups="mcollective,everyone"/>
        <authenticationUser username="admin" password="secret" groups="mcollective,admins,everyone"/>
```

In cobbler/settings, set default_password_crypted as directed.
