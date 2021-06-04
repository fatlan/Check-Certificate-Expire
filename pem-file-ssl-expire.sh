#!/bin/bash
# -------------------------------------------------------------------------------

# SSL pem file variables
pem="/fatlancom/certificate.pem"

# 7 days in seconds 
day="604800"

# Email settings for 587 mail port, to 25 mail port no auth
sub="Warning: ** $pem about SSL expire**"
from="sysadmin@sysadmin.tr"
to="sysadmins@sysadmin.tr"
authuser="sysadmin@sysadmin.tr"
authpass="password"
mailserver="mta.sysadmin.tr"
port="587"

# The certificate calculates the remaining days
openssl x509 -enddate -noout -in "$pem"  -checkend "$day" | grep -q 'Certificate will expire'

# Send email
if [ $? -eq 0 ]
then

        swaks  --to "$to" --from "$from" --server "$mailserver" --port $port --auth LOGIN --auth-user "$authuser" --auth-password "$authpass" -tls --header "Subject:$sub" --body "The TLS/SSL certificate $pem file will expire after 7 days on $HOSTNAME machine\n\n[$(date)]" --hide-all 2> /dev/null

fi


