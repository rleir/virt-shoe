# virt-shoe

# Given a server with no operating system loaded, how quickly can you have it up ready to host virtual servers or containers? For us, about an hour, mostly unattended.

This project uses Cobbler, Puppet and OpenVZ to do just that.

Hardware: we use HP 1U E5620 servers with 96G RAM and a few terabytes of disk space. More or less would be fine. 

A support server serves PXE boot, and has the Puppet master. We named it Borvo2, and you will see this name upon occasion below. 

The steps to load a blank server (assuming that virt-shoe has been installed on Borvo2):

* Optionally, start a clock with a seconds hand: xclock -up 1
* Press the server's power button and note the time. The server starts Power On Self Test (POST), and expect to see no video for the first minute or so.. After about 1.75 minutes, there will be a prompt to 'press any key to view option rom messages'.
* Press a key, and within 5 seconds you will see 'press CTRL-s for PXEboot options'. The defaults are fine, so do not press CTRL-s. 
* If you want to skip the long POST and get to the next step, press 'ESC'. This works at several places in the BIOS/POST startup. 
* Be ready for the ILOM options. 
* After the PXE boot is set up, you will see a prompt for ILOM: You now have a second to press F8.
* In the Network Configuration tab: Disable DHCP because we don't want to be depending on a DHCP server when things are going wrong. Other settings: 
* Network Interface Adapter to 'Shared Network Port'
* Virtual LAN to Enabled
* Virtual LAN ID to 100
* IP <host-ip>
* netmask 255.255.255.224 or whatever
* Gateway <gateway-ip>
* In the Users tab, give the Administrator account a password. 
* In the Settings tab: Lights-Out Functionality Enabled
* The ILOM license activation key must be obtained from HP. Allow time for this all.
* Now that the ILOM is working, the keyboard and display are not needed, and you can access the console via the ILOM from any PC. When you reboot the server, the ILOM allows you to view the whole thing, except that you may have to restart the ILOM when you have reset.
* Start the server. If it is not in its default state new-from-HP, then in the BIOS go to 'System Default Options' and choose the option to Restore Settings/Erase Boot Disk. At this point you may have to restart the Remote Console. 
* in the BIOS go to System Options -> Embedded NICs -> NIC 2 boot options
* Set it to Network Boot. No other BIOS changes are needed. Exit and it will reboot. 
* When the server boots, it will automatically PXE boot from Borvo2 Cobbler, use Kickstart to set up the disk and install Centos, then reboot from the hard disk, then set up everything from the Borvo2 Puppet server. This takes more than half an hour. 
* Within about 15 minutes, you have to go to Borvo2 and check that signall is running. ps -aef |grep signall
* If it is not, then cd /root; ./signall.sh &
* This script can be left running eternally on Borvo2.
* You could also check puppet. If it has been stopped, then restart it: /etc/init.d/puppetmaster start

* Also within about 15 minutes, you need to start the puppet framework, using the IP you chose for the new server: 
* 

* 


