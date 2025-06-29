echo "🚀 Starting DevOps Environment Setup..."

echo "===> Step 1: 🔧 Updating system"
# 1. System Update
sudo apt update && sudo apt upgrade -y

echo "===> Step 2: 🔧 Removing snap versions of tools..."
# 2. Remove conflicting Snaps
for pkg in docker aws-cli doctl microk8s google-cloud-sdk heroku powershell terraform ansible; do
  sudo snap remove $pkg || true
done

echo "===> Step 3: Installing prerequisites..."
# 3. Prerequisites
sudo apt install -y ca-certificates curl gnupg lsb-release software-properties-common apt-transport-https unzip

echo "===> Step 4: 🐳 Installing Docker from official APT repo..."

# 4. Docker (Official)
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker & Compose plugin
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group (optional, so you don’t need sudo every time)
sudo usermod -aG docker $USER

# 5. Docker Compose Aliases
echo "alias dcu='docker compose up -d'" >> ~/.bash_aliases
echo "alias dcd='docker compose down'" >> ~/.bash_aliases
echo "alias dcb='docker compose build'" >> ~/.bash_aliases

echo "===> Step 5: 📦 Installing Minikube..."
# 6. Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "===> Step 6: ☸️ Installing kubectl..."
# 7. kubectl
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
echo "alias k='kubectl'" >> ~/.bash_aliases

echo "===> Step 7: Installing Helm..."
# 8. Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" |   sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update && sudo apt install -y helm

echo "===> Step 8: 🤖 Installing Ansible..."
# 9. Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
echo "alias ans='ansible'" >> ~/.bash_aliases

echo "===> Step 9: 🌍 Installing Terraform...”
# echo "===> Step 9: 🌍 Installing Terraform...”
# 10. Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg |   sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg

echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg]   https://apt.releases.hashicorp.com $(lsb_release -cs) main" |   sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform
echo "alias tf='terraform'" >> ~/.bash_aliases

echo "===> Step 10: Installing Packer and Vagrant..."
# 11. Packer & Vagrant
sudo apt install -y packer vagrant

echo "===> Step 11: 🌤️ Installing AWS CLI v2..."
# 12. AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install
rm -rf aws awscliv2.zip

echo "===> Step 12: 🌤️ Installing Google Cloud SDK..."
# 13. Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg]   https://packages.cloud.google.com/apt cloud-sdk main" |   sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |   sudo apt-key add -
sudo apt update && sudo apt install -y google-cloud-sdk

echo "===> Step 13: 🌤️ Installing Azure CLI..."
# 14. Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "===> Step 14: Installing Vault CLI..."
# 15. Vault CLI
sudo apt install -y vault

echo "===> Step 15: 🔷 Installing doctl (DigitalOcean CLI)..."
# 16. doctl (DigitalOcean)
curl -sL https://github.com/digitalocean/doctl/releases/latest/download/doctl-$(uname -s)-$(uname -m)   -o doctl
chmod +x doctl
sudo mv doctl /usr/local/bin

echo "===> Step 16: Installing GitHub CLI..."
# 17. GitHub CLI
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |   sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg]   https://cli.github.com/packages stable main" |   sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y

echo "===> Step 17:  Installing Jenkins CLI..."
# 18. Jenkins CLI (Manual)
mkdir -p ~/jenkins && cd ~/jenkins
curl -O http://localhost:8080/jnlpJars/jenkins-cli.jar || echo "Jenkins must be running locally"
cd ~

echo "===> Step 18:  Installing Prometheus..."
# 19. Prometheus
cd /tmp && curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest   | grep browser_download_url | grep linux-amd64.tar.gz | cut -d '"' -f 4 | wget -qi -
tar -xzf prometheus-*-linux-amd64.tar.gz
sudo mv prometheus-*-linux-amd64/prometheus /usr/local/bin/
rm -rf prometheus-*-linux-amd64*

echo "===> Step 19: ☸️ Installing k9s..."
# 20. k9s
curl -s https://api.github.com/repos/derailed/k9s/releases/latest |   grep browser_download_url | grep Linux_x86_64.tar.gz | cut -d '"' -f 4 | wget -qi -
tar -xzf k9s_Linux_x86_64.tar.gz
chmod +x k9s && sudo mv k9s /usr/local/bin
rm -f k9s_Linux_x86_64.tar.gz

echo "===> Step 20: 🌍 Installing Apache and NGINX..."
# 21. Apache & NGINX
sudo apt install -y apache2 nginx

echo "===> Step 21: 🔷 Installing VSCode..."
# 22. VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"   > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

echo "==> Step 22: 🛠️ Ensuring .bashrc sources .bash_aliases..."
# 23. Source aliases
if ! grep -q "bash_aliases" ~/.bashrc; then
  echo -e "\nif [ -f ~/.bash_aliases ]; then\n  . ~/.bash_aliases\nfi" >> ~/.bashrc
fi

# 24. Done
echo "✅ DevOps setup complete. Tools installed successfully.
echo “🔄 Please reboot or run: newgrp docker && source ~/.bashrc"
