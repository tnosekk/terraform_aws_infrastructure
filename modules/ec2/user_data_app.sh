#!/bin/bash

yum update -y
yum install -y python3 python3-pip

mkdir -p /opt/app
cat > /opt/app/app.py << EOF
from http.server import HTTPServer, BaseHTTPRequestHandler
import json

class AppHandler(BaseHTTPRequestsHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

        response = {
            'message': 'Hello from ${project_name} app server',
            'environment': '${environment}',
            'status': 'running'
        }

        self.wfile.write(json.dumps(response).encode())

if __name__ == '__main__':
    sever = HTTPServer(('0.0.0.0', 8080), AppHandler)
    print('App server running on port 8080)
    server.serve_forever()
EOF

cat > /etc/systemd/system/app.service << EOF
[Unit]
Description=Python App Server
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/opt/app
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable app
systemctl start app