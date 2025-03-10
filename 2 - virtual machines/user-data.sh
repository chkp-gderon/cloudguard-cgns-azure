#!/bin/bash

# update Rocky9
sudo dnf check-update
sudo dnf update -y

# install docker 
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker

sudo mkdir -p ~/docker-nginx1/html/
sudo mkdir -p ~/docker-nginx2/html/
sudo mkdir -p ~/docker-https/html

# pull NGINX container and build websites

sudo curl -k https://www.checkpoint.com/favicon.ico -o favicon.ico

sudo cp favicon.ico ~/docker-nginx1/html/ 
sudo cp favicon.ico ~/docker-nginx2/html/ 
sudo cp favicon.ico ~/docker-https/html/ 

sudo cat  << EOF > ~/index.html
<html>
  <head>
    <title>Nginx 1</title>
  </head>

  <body>
    <div class="container">
      <h1>Hello Check Point 1</h1>
      <p>This Nginx page is brought to you by magic 1</p>
    </div>
  </body>
</html>
EOF

sudo cp ~/index.html ~/docker-nginx1/html/index.html
sudo sed -i s/"Hello Check Point 1"/"Hello Check Point 1 $(hostname)"/ ~/docker-nginx1/html/index.html
sudo sed -i s/"magic 1"/"magic 1 $(hostname)"/ ~/docker-nginx1/html/index.html
sudo cp ~/index.html ~/docker-nginx2/html/index.html
sudo sed -i s/"Hello Check Point 1"/"Hello Check Point 2 $(hostname)"/ ~/docker-nginx2/html/index.html
sudo sed -i s/"magic 1"/"magic 2 $(hostname)"/ ~/docker-nginx2/html/index.html

sudo cp ~/index.html ~/docker-https/html/index.html
sudo sed -i s/"Hello Check Point 1"/"Hello Check Point over TLS $(hostname)"/ ~/docker-https/html/index.html
sudo sed -i s/"magic 1"/"magic over HTTPS $(hostname)"/ ~/docker-https/html/index.html

# download juiceshop (if needed)
sudo docker pull bkimminich/juice-shop


# add container start to systemd or cron later

sudo docker run -d -p 80:80  -v ~/docker-nginx1/html:/usr/share/nginx/html nginx
sudo docker run -d -p 81:80  -v ~/docker-nginx2/html:/usr/share/nginx/html nginx

sudo docker run -d -p 79:3000 bkimminich/juice-shop