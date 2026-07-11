# iac-security-governance
An automated DevSecOps CI/CD pipeline enforcing shift-left security and compliance on Infrastructure-as-Code (Terraform) using Checkov

**Enterprise DevSecOps: Automated IaC Security Governance**

🛡️ Project Overview
This project demonstrates "Shift-Left Security" by engineering an automated continuous integration/continuous deployment (CI/CD) security gate. It prevents developers from deploying non-compliant or vulnerable cloud infrastructure (Infrastructure-as-Code) to production environments.

*Read the full architectural breakdown and case study on my Notion Portfolio: [https://app.notion.com/p/Template-IT-Engineering-Project-Showcase-DevSecOps-Pipeline-Automation-4d61b4e34b5848cc8fee01d1c81b8b03?pvs=28]

🏗️ Architecture & Technologies
i. Infrastructure as Code (IaC): HashiCorp Terraform
ii. CI/CD Orchestration: GitHub Actions
iii. Static Application Security Testing (SAST): Checkov
iv. Cloud Environment: AWS

🚀 The Workflow
Developer Commits Code: Terraform code defining cloud storage is pushed to the repository.
Pipeline Triggers: GitHub Actions automatically provisions a runner.
Security Scan: Checkov analyzes the .tf files against hundreds of enterprise security policies.
Enforcement:
- If a misconfiguration is detected (e.g., Public Access enabled), the build FAILS and blocks deployment.
- If the code is secure, the build PASSES, allowing deployment to proceed.

📸 Proof of Concept
1. The Interception (Failed Build)

(Screenshot of the red failed GitHub Action highlighting the Checkov error)

The pipeline successfully detects the intentionally misconfigured public storage bucket and halts the deployment.

2. The Remediation (Passed Build)

(Screenshot of the green passed GitHub Action)

After remediating the Terraform code to enforce private access, the security gate validates the changes and allows the build to pass.
