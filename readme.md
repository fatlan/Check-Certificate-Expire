# SSL Certificate Expiration Monitor Bash Scripts

**Must be openssl version 1.1** (otherwise openssl -checkend does not work)

Mail sender agent
~~~
sudo apt install swaks
~~~

Sample
~~~
swaks  --to fatlan@sysadmin.tr --from "alert@sysadmin.tr" --server mta.fatlan.com --port 587 --auth LOGIN --auth-user "alert@sysadmin.tr" --auth-password "password" -tls --header "Subject:test" --body "ssl expire" --hide-all
~~~

For 7 day(604800 seconds)

Check openssl sample1 for certificate pem file
~~~
openssl x509 -enddate -noout -in "/fatlancom/certificate.pem"  -checkend "604800" | grep -q 'Certificate will expire'
~~~

Check openssl sample2 for domain
~~~
echo | openssl s_client -servername fatlan.com -connect fatlan.com:443 | openssl x509 -noout -dates -checkend "604800"
~~~

Check everyday at 00:00 sample
~~~
crontab -e

0 0 * * * bash /fatlancom/ssl-expire-alert.sh >2 /dev/null
~~~

