#  Nginx HTTPS Setup on Kali Linux

This project automates the deployment of a secure Nginx web server on Kali Linux using a self-signed SSL certificate. It includes a Bash script that installs required packages, configures HTTPS, and generates a custom HTML homepage.

##  What the Script Does

- Installs Nginx
- Generates a self-signed SSL certificate
- Configures Nginx for HTTPS access
- Creates a custom index page
- Starts and enables the Nginx service

>  **Note:** Before running the script, edit the certificate generation section with your own organization info (e.g., country, city, etc.).

## Files

- `install_nginx_ssl.sh` — Main setup script
- `README.md` — This guide

##  Result

After running the script, your Kali machine will host a secure web page accessible via HTTPS with a custom message:  
**"It works, powered by Valerii Bykovskii"**

---

For educational purposes and internal lab testing only.
