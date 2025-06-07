#!/bin/bash

yum update -y
yum install -y httpd

systemctl enable httpd
systemctl enable httpd

cat >/var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>${project_name} - Web Server</title>
</head>
<body>
    <h1>Welcome to ${project_name}</h1>
    <h2>Environment: ${environment}</h2>
    <p>This is the web server running in a public subnet.</p>
    <p>Server IP: $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</p>
</body>
</html>
EOF

systemctl restart httpd
