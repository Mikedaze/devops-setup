DevOps Environment Setup Script
Welcome! This is a one-script DevOps workstation bootstrapper — designed to get you up and running with industry-standard tools for modern infrastructure, cloud, and CI/CD practices.

📌 Why This Script?
If you're just starting your DevOps journey, setting up your environment can feel overwhelming. You're often switching between documentation, tutorials, and terminal sessions, trying to install and configure multiple tools — and half the time, you're not even sure if they installed properly.
This script solves that.
✅ Installs everything you need in one go.
✅ Sets up sane defaults, aliases, and environment configurations.
✅ Replaces Snap-installed tools with official, reliable versions.
✅ Modular, editable, and beginner-friendly.



💠 What It Installs
Tool
Description
Docker
Container engine for building and running containers
Docker Compose
Tool for defining and running multi-container Docker apps
Minikube
Lightweight Kubernetes for local development
kubectl
Kubernetes command-line interface
Helm
Kubernetes package manager
k9s
TUI Kubernetes cluster management
Terraform
Infrastructure-as-code tool by HashiCorp
Ansible
Configuration management and automation tool
Packer
Tool for building machine images (VMs, cloud, containers)
Vagrant
Tool for managing virtual machine environments
AWS CLI
Command-line interface for managing AWS services
Google Cloud SDK
CLI tools for interacting with Google Cloud Platform
Azure CLI
Manage Azure resources via command line
doctl
DigitalOcean CLI for managing droplets and Kubernetes
GitHub CLi
Interact with GitHub from the command line
Vault CLI
Secret management tool by HashiCorp
Heroku CLI
Interface for managing Heroku apps and deployments
PowerShell
Cross-platform automation shell from Microsoft
Prometheus
Metrics and monitoring toolkit
Jenkins CLI
Command-line interface for managing Jenkins jobs (requires Jenkins)
Apache
Popular open-source web server
NGINX
High-performance web server and reverse proxy
VSCode
Visual Studio Code editor from Microsoft


🧠 Why It Helps DevOps Beginners
No guesswork: Removes conflicting Snap versions and installs official packages from trusted sources.
Consistency: Uses standardized locations and versions, ensuring compatibility with most tutorials and production pipelines.
Speed: Get everything in one run — no Googling, no broken guides.
Learning-friendly: Readable, commented, and easy to modify.
Cross-cloud readiness: Ready for AWS, GCP, or DigitalOcean workflows.



🔪 Verified Tool Versions
After installation, the script checks:
docker --version
aws --version
gcloud version
az version
doctl version
gh --version
heroku --version
vault --version
kubectl version --client
minikube version
helm version
k9s version
terraform version
ansible --version
packer version
vagrant --version
prometheus --version
code --version


🗃️ Setup Aliases Automatically
To make your CLI experience faster and easier, the script adds:
alias k='kubectl'
alias mk='minikube'
alias tf='terraform'
alias ans='ansible'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'

These are stored in ~/.bash_aliases and sourced via .bashrc.

📦 How to Use It
Download or clone this repo
Make the script executable:

 chmod +x devops_full_setup.sh

Run the script:

 ./devops_full_setup.sh

Reboot or refresh your terminal:

 newgrp docker && source ~/.bashrc

⚠️ Requirements
Ubuntu 22.04 or 24.04


Internet connection


sudo privileges



📣 Perfect For:
Students and bootcamp grads learning DevOps
Developers transitioning into SRE or platform roles
Anyone setting up a local DevOps lab or cloud automation environment
Teams creating disposable VMs for CI/CD, demos, or training



📌 Final Thoughts
This script is not just about installing tools — it’s about accelerating your learning curve and removing friction. Focus on building and automating — not troubleshooting installations.

Contributions, suggestions, and forks welcome!
