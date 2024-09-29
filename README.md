# Infrastructure Project

![Terraform](https://img.shields.io/badge/Terraform-7F3C3C?style=flat-square&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-0033CC?style=flat-square&logo=ansible&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![OpenStack](https://img.shields.io/badge/OpenStack-FF5C5C?style=flat-square&logo=openstack&logoColor=white)

## Overview

This project focuses on automating server configuration using Terraform and Ansible. It involves deploying a functional web server and a MySQL database server on the CSCloud platform, all orchestrated through a shell script (`deploy.sh`). By executing the script, users can set up the entire infrastructure with minimal effort.

## Objectives

1. **Web Server Deployment**:
   - Create a functional web server accessible via a public IP on port 8082.
   - Serve a static webpage using the provided HTML code.

2. **Database Server Deployment**:
   - Deploy a MySQL database server accessible via a public IP on port 3306 (default for MySQL).

## Technologies Used

- **Terraform**: Infrastructure as Code tool for building, changing, and versioning infrastructure safely and efficiently.
- **Ansible**: Automation tool for configuration management and application deployment.
- **Bash**: Shell scripting for automating deployment processes.
- **OpenStack**: Cloud computing platform that provides infrastructure as a service.


## Instructions

1. **Prerequisites**:
   - Ensure you have exported the necessary variables for `identity_file` and `key_name`.

2. **Execution**:
   - To deploy the infrastructure, run the following command in the terminal:
     ```bash
     ./deploy.sh
     ```

3. **Output**:
   - The script will output the public IP addresses for both the web server and the MySQL database server.

4. **Teardown**:
   - To destroy the infrastructure, run:
     ```bash
     terraform destroy
     ```

## Notes

- **Security**: No user-specific information (like usernames, passwords, or private keys) is be hardcoded into any files. Users are responsible for providing their own credentials for the OpenStack provider.
  
- **Network Security**: Ensures that the database server is not accessible on port 8082 and the web server is not accessible on port 3306.

## Conclusion

This project provides an automated solution for setting up web and database servers, demonstrating best practices in infrastructure management. For questions or assistance, please reach me out at maricvanj@gmail.com .
