#!/bin/bash
set -e
lock=""
lock="$(confLock -o -iadmin)"
function run {
        local cmd="$1"
        clish -i -l "$lock" -s -c "$cmd" || true 
}

# This script as provided is a demonstration of what is possible. It may
# require modifications if error handling is required. (If the script fails
# with an error, the provisioning process will also fail with an error and
# stop. This will be visible in /var/log/CPcme/cme.log but the message may
# not be obvious as to the cause.

# uncomment the required lines

# set banner message for compliance (if required)

run 'set message banner off'
# run 'set message banner on'
# run 'set message banner on line msgvalue "RESTRICTED ACCESS"'
# run 'set message banner on line msgvalue "This System is private and confidential"'
# run 'set message banner on line msgvalue "This system is for the use of authorized users only"'
# run 'set message motd off'

# set expert password hash and session timeout 

# run 'set expert-password-hash $6$rounds=10000$TZXD8kp3$NorV4C/owLpGMjKKzW52RyQBNPXM3b43Krqdf7snJ/zn1KruUINJhpBYRLuVue2Q7fyTXZyeagHumTkezyDvW1'
run 'set inactivity-timeout 100'

# set proxy (if required)
# run 'set proxy address a.b.c.d port zz'

# add RBA user, RADIUS, and TACACS+ roles (if required) (adminRole and monitorRole already defined.)

# run 'add rba role TACP-0 domain-type System readwrite-features tacacs_enable,selfpasswd'
# run 'add rba role TACP-15 domain-type System all-features'

# add RADIUS / TACACS server(s)
# run 'add aaa tacacs-servers priority 1 server a.b.c.d key mysecretkey timeout 5'
# run 'set aaa tacacs-servers user-uid 0' 
# run 'set aaa tacacs-servers state on' 

# add local users (if required)

# run 'add user securityteam uid 0 homedir /home/securityteam'
# run 'set user securityteam gid 0 shell /etc/cli.sh'
# run 'set user securityteam realname "Security Team"'
# run 'set user securityteam password-hash $1$ocoA1HXt$i9junkouBiaEqNH0d1u1'
# run 'add rba user securityteam roles adminRole'

# # OpenSSH ciphers

# run 'set ssh server cipher aes256-cbc on'
# run 'set ssh server cipher aes256-ctr on'
# run 'set ssh server cipher aes256-gcm@openssh.com on'
# run 'set ssh server kex diffie-hellman-group-exchange-sha256 on'
# run 'set ssh server kex curve25519-sha256@libssh.org on'
# run 'set ssh server mac hmac-sha2-512-etm@openssh.com on'
# run 'set ssh server mac hmac-sha2-256-etm@openssh.com on'
# run 'set ssh server mac umac-128-etm@openssh.com on'
# run 'set ssh server mac hmac-sha2-512 on'
# run 'set ssh server mac hmac-sha2-256 on'
# run 'set ssh server mac umac-128@openssh.com on'

# # HTTPS versions and ciphers in Gaia (not HTTPSi)
# run 'set web ssl3-enabled off'
# run 'set ssl tls TLSv1 off'
# run 'set ssl tls TLSv1.1 off'
# run 'set ssl tls TLSv1.2 on'
# run 'set ssl tls TLSv1.3 on'

# cp /web/templates/httpd-ssl.conf.templ /web/templates/httpd-ssl.conf.templ.ORIG
# chmod +w /web/templates/httpd-ssl.conf.templ
# # R81.20 original ciphers: SSLCipherSuite HIGH:!RC4:!LOW:!EXP:!aNULL:!SSLv2:!MD5
# # requested by customer : SSLCipherSuite ECDHE-RSA-AES256-SHA384:AES256-SHA256:!ADH:!EXP:RSA:+HIGH:+MEDIUM:!MD5:!LOW:!NULL:!SSLv2:!eNULL:!aNULL:!RC4:!SHA1

# sed -i s/'SSLCipherSuite'/'# SSLCipherSuite'/ httpd-ssl.conf.templ
# sed -i /'SSLCipherSuite/i \SSLCipherSuite ECDHE-RSA-AES256-SHA384:AES256-SHA256:!ADH:!EXP:RSA:+HIGH:+MEDIUM:!MD5:!LOW:!NULL:!SSLv2:!eNULL:!aNULL:!RC4:!SHA1 \' httpd-ssl.conf.templ

# chmod -w /web/templates/httpd-ssl.conf.templ
# /bin/template_xlate : /web/templates/httpd-ssl.conf.templ /web/conf/extra/httpd-ssl.conf < /config/active
# tellpm process:httpd2
# tellpm process:httpd2 t

# # disable port 264 - gateway actions - recommended to edit $CPDIR/lib/implied_rules.def and comment out /* define ENABLE_FWD_TOPO */
# ckp_regedit -a SOFTWARE\\CheckPoint\\VPN1 TOPO_SRV_ENABLED -n 0
# fw kill vpnd

# # disable port 900 - port 259 already disabled
# cp $FWDIR/conf/fwauthd.conf $FWDIR/conf/fwauthd.conf.ORIG
# sed -i s/'^900     fwssd/# 900     fwssd'/ $FWDIR/conf/fwauthd.conf

# cpwd_admin stop -name FWD -path "$FWDIR/bin/fw" -command "fw kill fwd"
# cpwd_admin start -name FWD -path "$FWDIR/bin/fw" -command "fwd"


# Openssh Keys etc
# If version is R80.40 or higher, OpenSSH keys are managed with CLISH commands
# tbc

# If version R80.30 or lower, OpenSSH keys are managed with shell commands

# cd /home/admin
# mkdir -p .ssh 
# chmod u=rwx,g=,o=  .ssh
# touch .ssh/authorized_keys
# touch .ssh/authorized_keys2
# chmod u=rw,g=,o=  .ssh/authorized_keys
# chmod u=rw,g=,o=  .ssh/authorized_keys2

# cat >> .ssh/authorized_keys <<EOF
#ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA6rBZuY+YC16TzHDD+zWo7Gbcrw561gZ6EN+M1Z4hNiKTkQm9cpsVKK9lsb8BEHoWU2E6zoyEniA2cK6A3XQAOb+S1Jj90o8uEWuQrNoPz4J8cFwPjdr1PM7D+bahrp3m1355fTTK2upVV6bKUs4157Bvgd9bl89a+p2E7Xcu0I46CCq8gn9Ra7OETTwCmLvaQ5rUEgyrGTQAGjunkcWDX1sFjobR91KokWeyAq0fZ7cKwztbhfXuaFSalDlJxdcZuKVVw3pFsGKGgD40nRysZPKb2sqTxZflH1ZYJls3O44yGqCcp2tMU4TxrCi5oJXbevpJ5fldsGy1AxoAWtkLvit29K3hSuwD3muZAd1lckbowj1YBN5xuw4NrmnKs3klIeIvOqIfIUH6GNTBDr+ceMrzd7gWZaBAzPkQMQLnc4v7N2YpMzPTSgQpA8/qaPHaZ0lQUOsAfnWTdhA1DQDSn+p6KFUYHDp2v/XJ0CYRYBOUCNsU/Do2b1eGpnL6EX6y43ENbeGFFhv59gBieJDr6kn9+hmSNWWHNlIoCmHIfCo85AJflT0bMDwKUlUi4RDRWMdXfdq0LqSsWqkhiJabtQM9SspamMe600jX0VLCgEDOpT4YApOeUsGyXMQFIUa9aDqqNw7u+kwDjPaT5yxmGXIYhByUVX+CraqScdlOG8A0BuU= admin@testsms
#
#EOF
# cat >> .ssh/authorized_keys2 <<EOF2
#ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA6rBZuY+YC16TzHDD+zWo7Gbcrw561gZ6EN+M1Z4hNiKTkQm9cpsVKK9lsb8BEHoWU2E6zoyjunkEniA2cK6A3XQAOb+S1Jj90o8uEWuQrNoPz4J8cFwPjdr1PM7D+bahrp3m1355fTTK2upVV6bKUs4157Bvgd9bl89a+p2E7Xcu0I46CCq8gn9Ra7OETTwCmLvaQ5rUEgyrGTQAGcWDX1sFjobR91KokWeyAq0fZ7cKwztbhfXuaFSalDlJxdcZuKVVw3pFsGKGgD40nRysZPKb2sqTxZflH1ZYJls3O44yGqCcp2tMU4TxrCi5oJXbevpJ5fldsGy1AxoAWtkLvit29K3hSuwD3muZAd1lckbowj1YBN5xuw4NrmnKs3klIeIvOqIfIUH6GNTBDr+ceMrzd7gWZaBAzPkQMQLnc4v7N2YpMzPTSgQpA8/qaPHaZ0lQUOsAfnWTdhA1DQDSn+p6KFUYHDp2v/XJ0CYRYBOUCNsU/Do2b1eGpnL6EX6y43ENbeGFFhv59gBieJDr6kn9+hmSNWWHNlIoCmHIfCo85AJflT0bMDwKUlUi4RDRWMdXfdq0LqSsWqkhiJabtQM9SspamMe600jX0VLCgEDOpT4YApOeUsGyXMQFIUa9aDqqNw7u+kwDjPaT5yxmGXIYhByUVX+CraqScdlOG8A0BuU= admin@testsms
#
#EOF2

# here-document with any ssh keys to append

# syslog server settings

# run 'add syslog log-remote-address a.b.c.d  level info'

# SNMP v2 and v3 settings

# run 'set snmp agent on'
# run 'set snmp agent any'
# run 'set snmp contact "Administrator"'
# run 'set snmp traps receiver a.b.c.d version v3'
# run 'set snmp traps receiver a.b.c.d community verysecret version v2'

# # To add SNMPv3 USM with sha1: 
# # run 'add snmp usm user <username> security-level authPriv auth-pass-phrase <authpassphrase> privacy-pass-phrase <privacypassphrase> privacy-protocol AES authentication-protocol SHA256'
# dbset snmp:v3:user:<username>:auth:proto .1.3.6.1.6.3.10.1.1.3
# run 'set snmp usm user <username> security-level authPriv auth-pass-phrase <authpassphrase> privacy-pass-phrase <privacypassphrase>'

# time date timezone and ntp settings

# run 'set ntp active on'
# run 'set ntp server primary europe.pool.ntp.org version 4'
# run 'set ntp server secondary 0.pool.ntp.org version 4'
# run 'set timezone Etc / GMT'

# # DNS settings
# # run 'set dns primary a.b.c.d'
# # run 'set dns secondary a.b.c.d'
# # run 'set dns suffix companyname.local'
# # run 'set domainname companyname.com'
# # restart DNS daemon to load new values
# cpwd_admin stop -name WSDNSD -path "$FWDIR/bin/wsdnsd" -command "fw kill wsdnsd"
# cpwd_admin start -name WSDNSD -path "$FWDIR/bin/wsdnsd" -command "wsdnsd"

# backup

# Filesystem or other commands:

# any 'cp_log_export' commands (if management) or other bash commands / scripts.

# etc..!

# script finishes

# enable HASH / expert mode command logging 
# (May expose passwords / secrets.)
# https://support.checkpoint.com/results/sk/sk99134 
cp /etc/security/pam_env.conf{,_ORIGINAL}
echo 'BASH_LOGGER     DEFAULT="ON"' >> /etc/security/pam_env.conf
cp /etc/cli.sh{,_ORIGINAL}
sed -i '/Now launch the shell/a export BASH_LOGGER="ON"' /etc/cli.sh
cp /etc/profile{,_ORIGINAL}
sed -i 's/LOGNAME=/#LOGNAME=/' /etc/profile
cp /etc/sudoers{,_ORIGINAL}
cp /etc/sudoers /tmp/sudoers
sed -i 's/XAUTHORITY/XAUTHORITY BASH_LOGGER LOGNAME/' /tmp/sudoers
cp /tmp/sudoers /etc/sudoers
rm /tmp/sudoers
cp /etc/bashrc{,_ORIGINAL}
sed -i 's/HOSTNAME:`/HOSTNAME:`echo -ne "";/' /etc/bashrc
# end sk99134
exit

