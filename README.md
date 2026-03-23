# 🚀 Zota AWS Task – Serverless Secure Asset Proxy

## 📌 Overview

This project implements a **secure, serverless asset proxy** that retrieves private assets from S3 and serves them globally through a CDN.

### 🏗 Architecture

- **CloudFront** provides global caching and HTTPS access  
- **Lambda (Go, containerized)** acts as a secure proxy  
- **S3** stores private assets (not publicly accessible)

---

## 📂 Repository

Base task repository:  
https://github.com/radoslav-stefanov/devops-secops-task

---

## ⚙️ What Was Implemented

### 1. 🐳 Dockerfile

- Multi-stage build  
- Target architecture: `linux/arm64`  
- Runtime base image: `public.ecr.aws/lambda/provided:al2023`  
- Optimized for minimal image size and fast cold starts  

---

### 2. ☁️ Infrastructure (CloudFormation)

A single CloudFormation template that provisions:

- S3 Bucket (private)  
- IAM Role with least-privilege access  
- Lambda Function (container-based)  
- Lambda Function URL  
- CloudFront Distribution (connected to Lambda URL)  

---

### 3. 🔄 CI/CD (GitHub Actions)

Two-stage pipeline:

#### 🏗 Build Stage
- Run tests  
- Build Docker image  
- Push image to ECR  
- Tag images with **immutable tags**  

#### 🚀 Deploy Stage
- Automatically triggered after build  
- Deploy infrastructure using CloudFormation  
- Update Lambda to new image version  

---

## 🔒 Security Considerations

- S3 bucket is **private**  
- Access only via Lambda  
- No long-lived AWS credentials (uses GitHub OIDC / temporary credentials)  
- Principle of least privilege applied in IAM roles  
- CloudFront acts as the public entry point  

---

## 📦 Deliverables

- Dockerfile  
- CloudFormation template  
- GitHub Actions workflows  
- Working CloudFront distribution  
- Design notes (this document)  

---

## 🌐 Usage

After deployment, access via:


---

## 🧠 Design Notes

- Using Lambda Function URL simplifies integration with CloudFront  
- Containerized Lambda enables full control over runtime dependencies  
- Multi-stage Docker build reduces final image size  
- Immutable tagging ensures reproducible deployments  
- CloudFront improves latency and reduces Lambda invocations  

---
