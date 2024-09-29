# Exit immediately if a command exits with a non-zero status
set -e

# Navigate to the Terraform directory
cd  deploy/terraform|| exit

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Apply the Terraform configuration
echo "Applying Terraform configuration..."
terraform apply -auto-approve

echo "Terraform deployment completed successfully."

# Navigate to the Ansible directory
cd ../ansible

# Print the current working directory
echo "Current directory: $(pwd)"

# Apply the Ansible configuration
ansible-playbook -i inventory webservers.yml databases.yml --extra-vars="ansible_ssh_private_key_file=${TF_VAR_identity_file}"

# Get the output variables from Terraform after Ansible execution
echo "Retrieving output variables..."
cd ../terraform || exit  # Navigirajte ponovo do Terraform direktorijuma
database_server_private_ip=$(terraform output -raw database_server_private_ip)
database_server_public_ip=$(terraform output -raw database_server_public_ip)
web_server_private_ip=$(terraform output -raw web_server_private_ip)
web_server_public_ip=$(terraform output -raw web_server_public_ip)

# Print the IP addresses
echo "Database Server Private IP: $database_server_private_ip"
echo "Database Server Public IP: $database_server_public_ip"
echo "Web Server Private IP: $web_server_private_ip"
echo "Web Server Public IP: $web_server_public_ip"

echo "Deployment completed successfully."