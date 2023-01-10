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
#task 2 is done

#now the task 3 is as follows 
        
        
cd /var/www/html/ 
myhtml="/var/www/html"

if [[ ! -f ${myhtml}/inventory.html ]]; then echo -e 'Log Type\tTime Created\tType\tSize' | sudo tee $myhtml/inventory.html > /dev/null fi

if [[ ! -f ${myhtml}/inventory.html ]]; then size=$(du -h /tmp/${name}-httpd-logs-${timestamp}.tar | awk '{print $1}') echo -e "httpd-logs\t${timestamp}\ttar\t${size}" | sudo tee -a $myhtml/inventory.html > /dev/null fi

if ! crontab -l | grep -q "/root/Automation_Project/automation.sh"; then echo "* * * * * root /ro



