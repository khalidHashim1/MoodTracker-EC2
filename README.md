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

---

### ⚠️ Challenge Faced
After installing the SSL certificate with Certbot, the website was still not accessible over HTTPS.  
I later discovered that port **443 (HTTPS)** was not open in the EC2 security group.  
✅ After adding an inbound rule for port 443, HTTPS access worked correctly.

---

### ✅ Outcome
Successfully hosted a secure, static website on an AWS EC2 instance, gaining experience with:
- Instance provisioning and Linux setup
- Apache web server deployment
- Domain and SSL configuration (HTTPS)
- Troubleshooting security group/firewall issues
- SSH access using `.pem` key on Windows Terminal
