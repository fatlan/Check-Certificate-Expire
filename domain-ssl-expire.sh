#!/bin/bash
# -------------------------------------------------------------------------------

# SSL domain variables
domain="fatlan.com"
port="443"

# 7 days in seconds 
day="604800"

# Email settings for 587 mail port, to 25 mail port no auth
sub="Warning: ** FA $domain about SSL expire**"
from="sysadmin@sysadmin.tr"
to="sysadmins@sysadmin.tr"
authuser="sysadmin@sysadmin.tr"
authpass="password"
mailserver="mail.sysadmin.tr"
port="587"

# The certificate calculates the remaining days
echo | openssl s_client -servername $domain -connect $domain:$port 2> /dev/null | openssl x509 -noout -dates -checkend "$day" | egrep -q 'Certificate will expire'

# Send email
if [ $? -eq 0 ]
then

        swaks  --to "$to" --from "$from" --server "$mailserver" --port $mport --auth LOGIN --auth-user "$authuser" --auth-password "$authpass" -tls --header "Subject:$sub" --body "[$(date)]\n\nFA, The TLS/SSL certificate ($domain) will expire after 7 days." --hide-all 2> /dev/null

fi
