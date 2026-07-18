# Enterprise DevSecOps: Automated IaC Security Governance

🛡️ Project Overview
Modern enterprises cannot rely on manual security reviews for cloud deployments. It is too slow and prone to human error. This project demonstrates "Shift-Left Security" by engineering an automated continuous integration/continuous deployment (CI/CD) security gate. It prevents developers from deploying non-compliant or vulnerable cloud infrastructure to production environments.

*Read the full architectural breakdown and case study on my Notion Portfolio: [ https://app.notion.com/p/Enterprise-DevSecOps-Automated-IaC-Security-Governance-4d61b4e34b5848cc8fee01d1c81b8b03 ]

🏗️ Architecture & Technologies
i. Infrastructure as Code (IaC): HashiCorp Terraform
ii. CI/CD Orchestration: GitHub Actions
iii. Static Application Security Testing (SAST): Checkov (Palo Alto Networks)
iv. Cloud Environment: AWS

🚀 The Security Workflow
1. The Commit: A developer authors Terraform code defining a AWS S3 bucket and pushes it to the repository.
2. THe Trigger: GitHub Actions automatically provisions an ephemeral Ubuntu runner.
3. The Scan: Checkov parses the .tf files against hundreds of enterprise security and compliance policies (CIS, HIPAA, PCI-DSS).
4. The Enforcement:
- If a misconfiguration is detected (e.g., Public Access enabled, missing encryption), the pipeline acts as a hard gate, FAILS the build and blocking deployment.
- If the code is secure and compliant, the build PASSES thus allowing deployment to proceed.

📸 Proof of Concept
1. The Interception (Blocked Deployment)

   To prove the efficacy of the pipeline, a deliberate vulnerability (Public Read ACL) was introduced to the Terraform blueprint.

![checkov-red_failed.png](https://github.com/IrfanMias/iac-security-governance/blob/main/assets/checkov-red_failed.png)

2. Remediation & Exception Handling (Successful Deployment)

   The Terraform code was remediated to enforce strict private access, AES-256 encryption, and versioning. Additionally, precise Checkov exception tags (#checkov:skip) were implemented to demonstrate expert-level handling of false-positives and accepted business risks.

![checkov-green_passed.png](https://github.com/IrfanMias/iac-security-governance/blob/main/assets/checkov-green_passed.png)
