#!/bin/bash

# To get this script to work, run "chmod +x ./main.sh"
# To find all apt apps installed, run "apt list --installed"
# Please run this script as root.

# Adding execute permissions to the other files.  This will allow them to be used by this program.
#chmod +x /var/scripts/auditd.sh
#chmod +x /var/scripts/chkrootkit.sh
#chmod +x /var/scripts/clamav.sh
#chmod +x /var/scripts/libdate-manip-perl.sh
#chmod +x /var/scripts/libpam-cracklib.sh
#chmod +x /var/scripts/logwatch.sh
#chmod +x /var/scripts/managePorts.sh
#chmod +x /var/scripts/nano.sh
#chmod +x /var/scripts/net-tools.sh
#chmod +x /var/scripts/openssl.sh
#chmod +x /var/scripts/rkhunter.sh
#chmod +x /var/scripts/rsyslod.sh
#chmod +x /var/scripts/ufw.sh

# Variables
admins=("user1")
userstoadd=("user4" "user5")
groupstoadd=("group3" "group4")
userstodel=("user2" "user3")
groupstodel=("group1" "group2")

# This is the main function.  It acts as a menu.
function main {
   printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
   printf "   ______    ______    ______    __       __    ______               __      __    ________    __            ________   \n"
   printf "  /      \  /      |  /      \  /  \     /  |  /      \             /  |    /  |  /        \  /  |          /        \  \n"
   printf " /&&&&&&  | &&&&&&/  /&&&&&&  | &&  \   /&& | /&&&&&&  |            && |    && | /&&&&&&&&  | && |         /&&&&&&&&  | \n"
   printf " && \__&&/    && |   && | _&&/  &&$  \ /&&$ | && |__&& |   ______   && |    && | && |    && | && |         && |    && | \n"
   printf " &&      \    && |   && |/    | &&&&  /&&&& | &&    && |  |______|  && |    && | && |    && | && |         && |    && | \n"
   printf "  &&&&&&  |   && |   && |&&&& | && && &&/&& | &&&&&&&& |            &&&&&&&&&& | && |    && | && |         && |    && | \n"
   printf " /  \__&& |  _&& |_  && \__&& | && |&&$/ && | && |  && |            && |    && | && |    && | && |_______  && |    && | \n"
   printf " &&    && / / &&   | &&    && / && | $/  && | && |  && |            && |    && | && \    && | &&         | && \    && | \n"
   printf "  &&&&&&_/  &&&&&&_/  &&&&&&_/  &&_/     &&_/ &&_/  &&_/            &&_/    &&_/  &&&&&&&&_/  &&&&&&&&&&_/  &&&&&&&&_/  \n"
   printf "             __     __   _______    __     __   ___      __   ________   __     __        ______     ______             \n"
   printf "            /  |   /  | /       \  /  |   /  | /   \    /  | /        | /  |   /  |      /      \   /      \            \n"
   printf "            && |   && | &&&&&&&  \ && |   && | &&&& \   && | &&&&&&&&_/ && |   && |     /&&&&&&  | /&&&&&&  |           \n"
   printf "            && |   && | && |  && | && |   && | && && \  && |    && |    && |   && |     &&_/  && | &&_/  && |           \n"
   printf "            && |   && | && |  && / && |   && | && &&  \ && |    && |    && |   && |           && |       && |           \n"
   printf "            && |   && | &&&&&&& <  && |   && | && | && \&& |    && |    && |   && |          && /       && /            \n"
   printf "            && |   && | && |  && \ && |   && | && | &&  && |    && |    && |   && |        &&& /      &&& /             \n"
   printf "            && |   && | && |  && | && |   && | && |  && && |    && |    && |   && |      &&&  /___  &&&  /___           \n"
   printf "             &&&&&&&_/  &&&&&&&__/  &&&&&&&_/  &&_/   &&&&_/    &&_/     &&&&&&&_/      &&&&&&&&_/ &&&&&&&&_/           \n"
   printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Written by: Jackson Campbell ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
   printf "    1) Start                                                                                                            \n"
   printf "    2) Start audit service (Takes a long time)                                                                          \n"
   printf "    3) View checklist                                                                                                   \n"
   printf "                                                                                                                        \n"
   printf "    Disclaimers:                                                                                                        \n"
   printf "        This program does not any passwords.  This needs to be done manually.                                           \n"
   printf "        Note that any new groups will be empty, as you cannot make lists of lists.                                      \n"
   printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"

   read -r answer
   if [ "$answer" -eq 1 ]
      then start;
   elif [ "$answer" -eq 2 ]
      then auditSetup;
   elif [ "$answer" -eq 3 ]
      then checklist
   else
      main;
   fi
}

function start {
   # Differences  -- Implement later
   # Editing host.conf
   cp /etc/host.conf /etc/host.conf.bak > /dev/null
   echo "nospoof on" | tee -a /etc/host.conf
   echo "order bind,hosts" | tee -a /etc/host.conf
   ip link set dev promisc off  > /dev/null

   # Installing apt-get
   wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/apt_2.7.2_i386.deb -O apt-get.deb > /dev/null
   dpkg -i apt-get.deb > /dev/null

   # Updating all apps (snaps included)
   apt-get update > /dev/null
   apt-get upgrade > /dev/null
   snap refresh > /dev/null

   # Installing apps
   apt-get install -y auditd > /dev/null
   apt-get install -y chkrootkit > /dev/null
   apt-get install -y clamav > /dev/null
   apt-get install -y cron > /dev/null
   apt-get install -y git > /dev/null
   apt-get install -y libdate-manip-perl > /dev/null
   apt-get install -y libpam-cracklib > /dev/null
   apt-get install -y logwatch > /dev/null
   apt-get install -y nano > /dev/null
   apt-get install -y net-tools > /dev/null
   apt-get install -y openssl > /dev/null
   apt-get install -y rkhunter > /dev/null
   apt-get install -y rsyslod > /dev/null
   apt-get install -y ufw > /dev/null

   # Updating again to make sure everything is up to date (Can't be too careful!)
   apt-get update > /dev/null
   apt-get upgrade > /dev/null
   snap refresh > /dev/null

   # Enabling automatic updates.
   dpkg-reconfigure --priority=low unattended-upgrades > /dev/null
   unattended-upgrade -d > /dev/null

   # Uninstalling prohibited apps
   # Hacking tools
   apt-get remove aircrack-ng > /dev/null
   apt-get remove apache2 > /dev/null
   apt-get remove apktool > /dev/null
   apt-get remove autopsy > /dev/null
   apt-get remove deluge > /dev/null
   apt-get remove dirb > /dev/null
   apt-get remove dsniff > /dev/null
   apt-get remove ettercap > /dev/null
   apt-get remove fcracklib > /dev/null
   apt-get remove ftp > /dev/null
   apt-get remove httrack > /dev/null
   apt-get remove hydra > /dev/null
   apt-get remove john-the-ripper > /dev/null
   apt-get remove kismet > /dev/null
   apt-get remove linuxdcpp > /dev/null
   apt-get remove metasploit-framework > /dev/null
   apt-get remove netcat > /dev/null
   apt-get remove nikto > /dev/null
   apt-get remove nmap > /dev/null
   apt-get remove rfdump > /dev/null
   apt-get remove skipfish > /dev/null
   apt-get remove snapd > /dev/null
   apt-get remove snort > /dev/null
   apt-get remove sqlmap > /dev/null
   apt-get remove wifite > /dev/null
   apt-get remove wireshark > /dev/null
   apt-get remove yersinia > /dev/null
   apt-get remove zenmap > /dev/null
   # Games
   apt-get remove aisleriot > /dev/null
   apt-get remove endless-sky > /dev/null
   apt-get remove freeciv > /dev/null
   apt-get remove gnome-mahjongg > /dev/null
   apt-get remove gnome-mines > /dev/null
   apt-get remove gnome-sudoku > /dev/null
   apt-get remove gnomine > /dev/null
   apt-get remove wesnoth > /dev/null
   # Insecure software
   apt-get remove ldap-utils > /dev/null
   apt-get remove manaplus > /dev/null
   apt-get remove nis > /dev/null
   apt-get remove rpcbind > /dev/null
   apt-get remove rsh-client > /dev/null
   apt-get remove rsh-server > /dev/null
   apt-get remove rsync > /dev/null
   apt-get remove talk > /dev/null
   apt-get remove telnet > /dev/null
   apt-get remove telnetd > /dev/null
   # Unnecessary bloatware
   apt-get remove apport > /dev/null
   apt-get remove atd > /dev/null
   apt-get remove autofs > /dev/null
   apt-get remove avahi-daemon > /dev/null
   apt-get remove avahi-utils > /dev/null
   apt-get remove bind9 > /dev/null
   apt-get remove cups > /dev/null
   apt-get remove dovecot-imapd > /dev/null
   apt-get remove dovecot-pop3d > /dev/null
   apt-get remove iptables-persistent > /dev/null
   apt-get remove isc-dhcp-server > /dev/null
   apt-get remove nfs-common > /dev/null
   apt-get remove nfs-kernel-server > /dev/null
   apt-get remove nginx > /dev/null
   apt-get remove portmap > /dev/null
   apt-get remove python-zeitgeist > /dev/null
   apt-get remove rhythmbox-plugin-zeitgeist > /dev/null
   apt-get remove rpcbind > /dev/null
   apt-get remove slapd > /dev/null
   apt-get remove squid > /dev/null
   apt-get remove xserver-xorg* > /dev/null
   apt-get remove zeitgeist > /dev/null
   apt-get remove zeitgeist-core > /dev/null
   apt-get remove zeitgeist-datahub > /dev/null

   # Removing unused dependencies
   apt-get autoremove > /dev/null

   # Manages Firefox settings
   wget https://github.com/pyllyukko/user.js/raw/master/user.js > /dev/null
   mv ./user.js /etc/firefox/user.js > /dev/null

   FirefoxPref() {
      echo "user_pref($1, $2);" | tee -a user.js
   }

   FirefoxPref '"browser.safebrowsing.downloads.enabled"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.enabled"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.block_dangerous"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.block_dangerous"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.block_dangerous_host"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.block_potentially_unwanted"' "true"
   FirefoxPref '"browser.safebrowsing.downloads.remote.block_uncommon"' "true"
   FirefoxPref '"browser.safebrowsing.malware.enabled"' "true"
   FirefoxPref '"browser.safebrowsing.phishing.enabled"' "true"
   FirefoxPref '"dom.disable_during_load"' "true"
   FirefoxPref '"dom.block_multiple_popups"' "true"
   FirefoxPref '"dom.block_download_insecure"' "true"
   FirefoxPref '"dom.enable_performance"' "true"
   FirefoxPref '"dom.allow_scripts_to_close_windows"' "false"
   FirefoxPref '"media.autoplay.block-webaudio"' "true"
   FirefoxPref '"media.block-autoplay-until-in-foreground"' "true"
   FirefoxPref '"plugins.flashBlock.enabled"' "true"
   FirefoxPref '"privacy.socialtracking.block_cookies.enabled"' "true"
   FirefoxPref '"toolkit.telemetry.reportingpolicy.firstRun"' "false"

   # Fixing System file permissions
   chmod 000 /etc/shadow > /dev/null
   chmod 644 /etc/passwd > /dev/null
   chmod 600 /etc/ssh/ssh_host*key > /dev/null
   chmod 600 /etc/ssh/*key.pub > /dev/null
   chmod 640 /var/log  > /dev/null
   chmod 640 /var/log/syslog > /dev/null
   chown syslog /var/log/syslog > /dev/null
   chown root /var/log > /dev/null
   chgrp adm /var/log/syslog  > /dev/null
   chmod 755 /bin > /dev/null
   chmod 755 /sbin > /dev/null
   chmod 755 /usr/bin > /dev/null
   chmod 755 /usr/sbin > /dev/null
   chmod 755 /usr/local/bin > /dev/null
   chmod 755 /usr/local/sbin > /dev/null

   # Edits system files
   # Editing /etc/login.defs to set a max passwd age(90), min passwd age(7), warn age(14), number of retries(3), and a login timeout(30).
   printf "PASS_MAX_DAYS  90\nPASS_MIN_DAYS  7\nPASS_WARN_AGE  14\nLOGIN_RETRIES 3\nLOGIN_TIMEOUT  30" | tee -a /etc/login.defs
   # Editing sshd_config to set too many things to count.
   printf "PermitRootLogin no\nPermitUserEnvironment no\nPermitEmptyPasswords no\nProtocol 2\nPrintLastLog no\nPubkeyAuthentication yes\nRSAAuthentication yes\nLoginGraceTime 30\nClientAliveInterval 600\nClientAliveCountMax 1\nUsePAM yes\nUsePrivilegeSeparation yes\nStrictModes yes\nIgnoreUserKnownHosts yes\nIgnoreRhosts  > /dev/nullyes\nRhostsAuthentication no\nRhostsRSAAuthentication no\nHostBasedAuthentication no\nAllowTcpForwarding no\nX11Forwarding no\nLogLevel VERBOSE\nPort 2453" | tee -a /etc/ssh/sshd_config
   # Editing /etc/pam.d/common-auth to add 'deny=5 unlock_time=1800' to end of 'pam_tally2.so'
   printf "pam_tally2.so   deny=10 unlock_time=1800" | tee -a /etc/pam.d/common-auth
   # Editing /etc/pam.d/common-password to add 'minlen=8 remember=5' to 'pam_unix.so', and add 'ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-' to 'pam_cracklib.so'.
   printf "pam_unix.so  minlen=8 remember=5\npam_cracklib.so   ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-" | tee -a /etc/pam.d/common-password
   # Editing /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf to add 'allow-guest=false'. May cause an error.
   printf "allow-guest=false" | tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

   # Disabling unnecessary services
   echo DNSStubListener=no | tee -a /etc/systemd/resolved.conf; # DNS Server 1
   systemctl stop systemd-resolved; # DNS Server 2
   systemctl disable systemd-resolved # DNS Server 3
   echo inetd_enable=no | tee -a /etc/rc.conf # inetd
   systemctl stop nfs # NFS Server

   # Checks for open ports.
   netstat -tulpna | awk '{if ($7 != "-" && $7 != "" && $7 != "Address") print $7;}' | tee -a pids.txt  # Puts the process ids into a text file
   netstat -tulpna | awk '{if ($7 != "-" && $7 != "" && $4 != "Local") print $4;}'   | tee -a ports.txt # Puts the ports into a text file

   sed -i '1d' processes.txt > /dev/null
   while read -r -u 10 pid && read -r -u 11 port
   do
      command=$(ps -p "$pid" | awk '{if ($4 != "CMD") print $4;}')

      printf "Port: %s, Command: %s, PID: %s" "$port" "$command" "$pid" | tee -a /var/output/finalPorts.txt # Puts an outline of each port and the pid/command using it.
   done 10<pids.txt 11<ports.txt

   # Removing unnecessary files.
   rm pids.txt > /dev/null
   rm ports.txt > /dev/null

   # Windows command is netstat -ano, in case that is ever helpful.
   printf "When you have looked through the finalPorts.txt file in /var/output"
   while (true)
   do
      VAR10=0
      VAR11=""
      echo "What port do you want to close?"
      read -r VAR10
      ufw deny "$VAR10" > /dev/null
      echo "Do you want to close another port? [Y/n]"
      read -r VAR11
      if [ "$VAR11" != "Y" ] && [ "$VAR11" != "y" ]; then
         break > /dev/null
      fi
   done

   # Puts the cron jobs onto the desktop.  (Both user and root)
   for filename in /var/spool/cron/crontabs/*; do
      cat "$filename" | tee -a /var/output/cronjobs.txt
   done
   cat /etc/crontab | tee -a /var/output/cronjobs.txt
   # Use 'crontab -r' to remove unnecessary jobs.

   # Network Protections (Lines 74-90)
   # Setting up firewall
   ufw allow in on lo > /dev/null
   ufw allow out on lo > /dev/null
   ufw deny in from 127.0.0.0/8 > /dev/null
   ufw deny in from ::1 > /dev/null
   ufw allow ssh > /dev/null
   ufw allow http > /dev/null
   ufw deny 23 > /dev/null
   ufw default deny > /dev/null
   ufw --force enable > /dev/null

   # Enabling cookie protection
   sysctl -n net.ipv4.tcp_syncookies > /dev/null

   # Disabling ipv6
   echo "net.ipv6.conf.all.disable_ipv6 = 1" | tee -a /etc/sysctl.conf

   # Disabling IP forwarding
   echo 0 | tee -a /proc/sys/net/ipv4/ip_forward

   # Preventing IP Spoofing
   echo "nospoof on" | tee -a /etc/host.conf

   # Deleting prohibited files (This may delete files needed for the image, be careful!)
   find / -type f -name "*.mp3" -delete > /dev/null

   # User Management (Lines 93-118)
   # This will create all the users specified in the userstoadd array.
   for user in "${userstoadd[@]}"
   do
      useradd "$user" -m > /dev/null
   done

   # This will create all the groups specified in the groupstoadd array as well as get the people that need to be added to that group.
   for group in "${groupstoadd[@]}"
   do
      groupadd "$group" > /dev/null
      printf "How many users should be in the group %s?" "$group"
      read -r count
      for ((i = 0; i < "$count"; i++))
      do
         echo "Please enter the name of user #$i"
         read -r user
         usermod -aG "$user" > /dev/null
      done
   done

   # Deletes all the users specified in the userstodel array.
   for user in "${userstodel[@]}"; do
      userdel "$user" -rf > /dev/null
   done

   # Deletes all the groups specified in the groupstodel array.
   for group in "${groupstodel[@]}"; do
      groupdel "$group" -f > /dev/null
   done

   # These commands will remove admin rights from all users and then give them back to the users specified in the admins array.
   # Removing admin permissions
   getent passwd | awk -F: '{if ($3 | tee -a 999 && $3 != 65534) print $1}' | xargs -I {} bash -c 'gpasswd -d "$@"' _ {} > /dev/null

   # Giving back admin permissions
   for admin in "${admins[@]}"; do
      gpasswd -a "$admin" > /dev/null
   done

   main
}

function auditSetup {
   # Setting up audit services
   augenrules --load > /dev/null
   systemctl enable rsyslog > /dev/null
   systemctl restart rsyslog > /dev/null

   main
}

function checklist {
   printf "Checklist\n"
   printf "    1) Install and run ClamAV\n"
   printf "    2) Install and start ufw\n"
   printf "    3) Update apps\n"
   printf "    4) Read readme, there will definitely be something in there for points\n"
   printf "    5) Check past checklists (Here's one!).\n"
   printf "    6) Help teamates.\n"
   printf "    7) Get teamates to help you.\n"
   printf "    8) Win!!!\n\n"

   read -rp "Press any key to resume..."

   main
}

main