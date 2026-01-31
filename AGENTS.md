# AGENTS.md - Infrastructure Module

This file contains mandatory rules and context for AI agents working on the **learning-english-infra** Terraform infrastructure module.

## Mandatory Rules

### 1. Context7 Usage (Mandatory)

涉及以下任何情况时，**必须**先调用 Context7 工具，不得凭记忆假设：

| 场景          | 必须检查 | 示例                               |
| ------------- | -------- | ---------------------------------- |
| 版本号约束    | ✅       | `version = "~> 5.0"`               |
| Provider/插件 | ✅       | hashicorp/google, google-beta      |
| 模块导入      | ✅       | 任何 Terraform module 引用         |
| API 调用      | ✅       | GCP API、Firebase API              |
| 配置文件      | ✅       | `main.tf`、`.tfvars` 中的依赖      |

### 2. Code Generation Rules

生成 **所有 `.tf` 文件** 时禁止添加任何注释：

- ❌ 行内注释：`# 这是注释`
- ❌ 块注释：`/* ... */`

**例外情况**：用户明确要求添加注释时 ✅

### 3. Terraform Style Guide

本项目使用项目级 skill：`terraform-style-guide`

安装位置：`learning-english-infra/.agents/skills/terraform-style-guide/`

核心规范：
- 文件命名：`terraform.tf`, `providers.tf`, `main.tf`, `variables.tf`, `outputs.tf`
- 缩进：2 个空格
- 命名规范：snake_case，描述性名词
- 变量定义：必须包含 type 和 description
- 资源创建：优先使用 `for_each` 而非 `count`

---

## Module Context

### Technology Stack

| Category         | Technology                                    |
| ---------------- | --------------------------------------------- |
| IaC Tool         | Terraform >= 1.10.0                           |
| Cloud Provider   | Google Cloud Platform (GCP)                   |
| Region           | asia-east2 (Hong Kong)                        |
| Services         | Firebase, Firestore                           |
| Providers        | hashicorp/google ~> 7.0, google-beta ~> 7.0   |

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
├── .agents/skills/             # Project-level agent skills
│   └── terraform-style-guide/
└── .terraform/                 # Terraform state
```

### Common Commands

```bash
# Initialize
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Format code
terraform fmt -recursive

# Validate configuration
terraform validate
```

### State Management

- Backend: Local (`.terraform.tfstate`)
- Lock file: `.terraform.tfstate.lock.info`
- Backup files: `.terraform.tfstate.backup.*`

### GCP Project Details

- Project ID: `learning-english-477407`
- Region: `asia-east2` (Hong Kong)

### Firestore Security Rules

安全规则定义在：`modules/firebase/firestore.rules`

规则要点：
- 仅认证用户可访问
- 基于 userId 的路径安全
- 数据验证和类型检查
