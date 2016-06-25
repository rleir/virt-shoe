# ILOM Configuration

ILOM stands for I Lights Out Management. It saves you a trip to the server room, you can access the console remotely. But you rarely need the console on a well managed system, so this is optional.

In the BIOS Settings tab, set 
```
Lights-Out Functionality Enabled
iLO 3 ROM-based setup utility    Enabled
RBSU  Disabled
POST   Enabled
```


The ILOM license activation key must be obtained from HP at hp.com/software/licensing (they send it to you by email). If you have not done this, they block you when you try to access the ILOM remotely from a browser. Allow time for their complicated procedures, and this part of the installation can not be automated. Connect a network cable to the ILOM port. Determine the IP you assigned it above (manually or by DHCP), and point a browser at it. Enter the username/password you entered above. Under Administration->Licensing, enter the activation key you have obtained by email.

For a virtual console using Java, you will need to enable the FireFox Java plugin.

# HPONCFG Configuration
You don't want to be physically in front of the machine, and you don't want to have to reboot, so instead of using
PROM F8 you can install and use hponcfg. It is rarely used, and might not be worth the effort.

Grep hponcfg redhat, and go to the hp link. You are expecting version hponcfg-4.0.0-0.noarch. Downloaded from here: 
```
h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1146658&prodNameId=1135772&swEnvOID=4103&swLang=8&mode=2&taskId=135&swItem=MTX-6b79c789b6cf4fd280ff717b44
```
Get the rpm and install it. 
```
rpm -ivh hponcfg-4.0.0-0.noarch.rpm
```
It is a 32 bit app running on a 64 bit machine so we also need: 
```
yum install glibc.i686
```
Read about it: 
```
more /usr/share/doc/hponcfg/readme.txt
```
Paste the following into a text editor and save as resetilopwd.xml : 
```
<RIBCL VERSION="2.1">
<LOGIN USER_LOGIN="Administrator" PASSWORD="anyoldthing">
<USER_INFO MODE="write">
<MOD_USER USER_LOGIN="Administrator">
<PASSWORD value="newpassword"/>
</MOD_USER>
</USER_INFO>
</LOGIN>
</RIBCL>
```
Reconfigure the ILOM: 
```
hponcfg -vf  resetilopwd.xml
```
Or to set all ILOM values, paste the following into a text editor and save as setilom.xml: 
```
<RIBCL VERSION="2.1">
<LOGIN USER_LOGIN="Administrator" PASSWORD="anyoldthing">
 <DIR_INFO MODE="write">
 <MOD_DIR_CONFIG>
   <DIR_AUTHENTICATION_ENABLED VALUE = "N"/>
   <DIR_LOCAL_USER_ACCT VALUE = "Y"/>
   <DIR_SERVER_ADDRESS VALUE = ""/>
   <DIR_SERVER_PORT VALUE = "636"/>
   <DIR_OBJECT_DN VALUE = ""/>
   <DIR_OBJECT_PASSWORD VALUE = ""/>
   <DIR_USER_CONTEXT_1 VALUE = ""/>
   <DIR_USER_CONTEXT_2 VALUE = ""/>
   <DIR_USER_CONTEXT_3 VALUE = ""/>
 </MOD_DIR_CONFIG>
 </DIR_INFO>
 <RIB_INFO MODE="write">
 <MOD_NETWORK_SETTINGS>
   <SPEED_AUTOSELECT VALUE = "Y"/>
   <NIC_SPEED VALUE = "10"/>
   <FULL_DUPLEX VALUE = "N"/>
   <SHARED_NETWORK_PORT VALUE = "Y"/>
   <VLAN_ENABLED VALUE = "Y"/>
   <VLAN_ID VALUE = "100"/>
   <IP_ADDRESS VALUE = "1.2.3.4"/>
   <SUBNET_MASK VALUE = "255.255.255.224"/>
   <GATEWAY_IP_ADDRESS VALUE = "1.2.3.1"/>
   <DNS_NAME VALUE = "ILOMXQ20702R8"/>
   <PRIM_DNS_SERVER value = "208.67.222.222"/>
   <DHCP_ENABLE VALUE = "N"/>
   <DOMAIN_NAME VALUE = "wan.example.net"/>
   <DHCP_GATEWAY VALUE = "N"/>
   <DHCP_DNS_SERVER VALUE = "N"/>
   <DHCP_STATIC_ROUTE VALUE = "N"/>
   <DHCP_WINS_SERVER VALUE = "N"/>
   <REG_WINS_SERVER VALUE = "N"/>
   <PRIM_WINS_SERVER value = "0.0.0.0"/>
   <STATIC_ROUTE_1 DEST = "0.0.0.0" GATEWAY = "0.0.0.0"/>
   <STATIC_ROUTE_2 DEST = "0.0.0.0" GATEWAY = "0.0.0.0"/>
   <STATIC_ROUTE_3 DEST = "0.0.0.0" GATEWAY = "0.0.0.0"/>
 </MOD_NETWORK_SETTINGS>
 </RIB_INFO>
<USER_INFO MODE="write">
<MOD_USER USER_LOGIN="Administrator">
<PASSWORD value="apassword"/>
</MOD_USER>
</USER_INFO>
</LOGIN>
</RIBCL>
```
Reconfigure the ILOM (this takes a few minutes to complete): 
```
hponcfg -vf  setilom.xml
```
There is an error mesage about libcpqci.so, but it does not matter. Check the results: 
```
hponcfg -w curr.xml
```
