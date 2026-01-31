# AGENTS.md - Infrastructure Module

本文件包含 AI agents 处理 **learning-english-infra** 模块时的上下文和补充规则。

## 基础规则继承

通用强制规则继承自根目录 [`../AGENTS.md`](../AGENTS.md)：
- Context7 Usage（强制）
- Code Generation Rules（强制）
- Agent Skill 安装规范

---

## 模块特定上下文

### Technology Stack

| Category         | Technology                                    |
| ---------------- | ----------------------------------------------- |
| IaC Tool         | Terraform >= 1.10.0                             |
| Cloud Provider   | Google Cloud Platform (GCP)                     |
| Region           | asia-east2 (Hong Kong)                          |
| Services         | Firebase, Firestore                             |
| Providers        | hashicorp/google ~> 7.0, google-beta ~> 7.0     |

### Directory Structure

```
learning-english-infra/
├── main.tf                     # Root Terraform configuration
├── modules/
│   └── firebase/
│       ├── main.tf             # Firebase project & web app
│       ├── firestore.tf        # Firestore database
│       ├── rules.tf            # Security rules deployment
│       ├── firestore.rules     # Firestore security rules
│       ├── variables.tf
│       └── outputs.tf
└── .terraform/                 # Terraform state (local backend)
```

### Common Commands

```bash
terraform init
terraform plan
terraform apply
terraform fmt -recursive
terraform validate
```

### GCP Project Details

- Project ID: `learning-english-477407`
- Region: `asia-east2` (Hong Kong)

### Context7 特别提示

涉及以下场景时必须调用 Context7：
- `hashicorp/google` provider 版本约束
- `google-beta` provider 版本约束
- 任何 Terraform module 引用
- GCP API 调用
- Firestore 安全规则语法

### Terraform Style Guide

本项目使用项目级 skill：`terraform-style-guide`

安装位置：`.agents/skills/terraform-style-guide/`

核心规范：
- 文件命名：`terraform.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf`
- 缩进：2 个空格
- 命名规范：snake_case，描述性名词
- 变量定义：必须包含 type 和 description
- 资源创建：优先使用 `for_each` 而非 `count`
