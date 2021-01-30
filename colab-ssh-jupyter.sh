# create an account on ngrok is not already and copy the authtoken and 
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
#read -p 'Enter the authtoken from ngrok :' authtoken
authtoken="1nn6c2ZVqb86fovF62VMfZk6K4K_2WEQH1XR3zpX6QAQ6yxme"
./ngrok authtoken $authtoken  #for example ZT64bWYnXTAsJej4FNFTdsjhsuAQqKqZHn2Sh4g2sfAD
./ngrok tcp 22 &
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc && echo "export LD_LIBRARY_PATH" >> /root/.bashrc
/usr/sbin/sshd -D &
mkdir /root/.ssh
#read -p "run 'ssh-keygen' on your local pc and \ncopy paste the content of ~/.ssh/id_rsa.pub file" rsa # for example https://imgur.com/a/z62timq
rsa="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIJNL/Gk65npKNnY4xGd0fV/BXWzilBmu6s9WDDqhl4OEUMIHfgKW/E73ohFJW6XQTlSuzziidtx9nV9V9Hro+km7b1c5DtHdOpT9oD0b6SK6umD8xWYnfu2M+gjijOHrTarWuOaUl6EfqYdcy97efH943FsDl+/083zqPaNlKCH6mFtB0E8mCRCoRmtoRSK8mthfeRrs0e0+p7eDvO9xOIZlnWy1MjzK/LOS5smriTkNQ63BdUW52vXx88DaNv2Rwj1JwQE1Bn06h6GxMloLIFsmz2XMEGXlDUSL2UG1EG6xI9/N0ALKuDgLuQbm3GA7LsBjgohh26oJAOxhBeXNZVfdULWQ0dnHoJhDBBxguRcoOCQsfLfmnB+u8hpwXryCXqhSTNzgnCIiBwbOe7n8ZdV2ojj99z4bZOutAHGXN7UBS9JkebiUND/ppxWN6k3vLE9U+x9WjV5NiYvmwxjcTL7PxV2sEEnNRc2qR5afHl7tYOwnAARENDZrN6IAVjS0= u0_a431@localhost"
echo $rsa >> /root/.ssh/authorized_keys
echo "You can connect to colab server on terminal with following command"
curl -s http://localhost:4040/api/tunnels | python3 -c \
    "import sys, json; print('ssh root@0.tcp.ngrok.io -p ' + json.load(sys.stdin)['tunnels'][0]['public_url'][-5:])"
    
