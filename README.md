## ☁️ AWS EC2 Web Hosting Project – MoodTrackerEC2

### 🔧 Overview
Deployed a basic website on an AWS EC2 instance using Amazon Linux 2. This project demonstrates how to host a static site using Apache on a secure and scalable virtual machine in the cloud.

---

### 📌 Steps Followed

#### 1. Launched EC2 Instance
- Used **Amazon Linux 2 AMI** (Free Tier eligible).
- Instance type: `t3.micro`
- Created a new key pair (`MoodTrackerEC2key.pem`) for SSH access.
- Configured **security group** to allow:
  - SSH (port 22) from my IP
  - HTTP (port 80) from anywhere

#### 2. Connected to EC2 via SSH (on Windows using Terminal)
```bash
chmod 400 /path/to/MoodTrackerEC2key.pem
ssh -i /path/to/MoodTrackerEC2key.pem ec2-user@<EC2_PUBLIC_IP>
```

#### 3. Installed Apache Web Server
```bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```

#### 4. Deployed Website Files
- Uploaded `index.html` to `/var/www/html/`:
```bash
sudo mv index.html /var/www/html/index.html
```

#### 5. Installed SSL Certificate (HTTPS)
- Used **Certbot** to issue a free SSL certificate.
- Configured Apache to use HTTPS.

#### 6. Assigned Elastic IP & Configured Subdomain
- Allocated an **Elastic IP** in the AWS EC2 dashboard.
- Attached the Elastic IP to the EC2 instance for persistent access.
- Created a **subdomain DNS record** (e.g., `web.mydomain.com`) in **Route 53**.
  - Record type: **A (IPv4 address)**
  - Pointed it directly to the EC2 instance’s Elastic IP.

---

### ⚠️ Challenges Faced
- After installing the SSL certificate with Certbot, the website wasn’t accessible via HTTPS.  
  🔍 Discovered that **port 443 (HTTPS)** was not open in the EC2 security group.  
  ✅ Solution: Added an inbound rule to allow port 443.
  
- Gained deeper understanding of DNS and IP assignment while linking a **subdomain to Elastic IP**.

---

### ✅ Outcome
Successfully hosted a secure, static website on an AWS EC2 instance, gaining experience with:
- Instance provisioning and Linux server setup
- Apache web server deployment and configuration
- SSL certificate management with Certbot (HTTPS)
- DNS configuration using Route 53 and Elastic IP
- Real-world troubleshooting (security groups, port access)
- SSH access using `.pem` key on Windows Terminal
