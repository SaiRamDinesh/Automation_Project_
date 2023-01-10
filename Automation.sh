install= dpkg --get-selections apache2 | awk '{print $2}'
if [[ install != ${install} ]];
then
        sudo apt install apache2
else
        echo "apache2 package is already installed"
fi



#to check apache2 service status running

status_check= (sudo systemctl status apache2 | grep running | awk '{print $3}' | tr -d '()')
#if the apache2 is not running

if [[ running != {$status_check} ]];
then
        sudo systemctl start apache2
else
        echo "apache2 service is already running"
fi

#to check apache2 service enabled
enabled= (systemctl is-enabled apache2)
if [[ enabled != ${enabled} ]];
then
        sudo systemctl enable apache2
else
        echo "apache2 service is already enabled"
fi
cd /var/log/apache2/
name="Dinesh"
timestamp=$(date '+%d%m%Y-%H%M%S')
tar -cf /tmp/${name}-httpd-logs-${timestamp}.tar *.log

s3_bucket="upgrad-dinesh"
aws s3 \
        cp /tmp/${name}-httpd-logs-${timestamp}.tar \
        s3://${s3_bucket}/${name}-httpd-logs-${timestamp}.tar



