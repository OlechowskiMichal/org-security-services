# Agent Instructions: org-aws-security-services

## Overview

Standalone OpenTofu module providing organization-wide AWS security services: GuardDuty, Security Hub, and IAM Access Analyzer. All services are delegated to a dedicated security-audit account.

## Architecture

This module operates across two AWS accounts:

- **Management account** (default provider) -- enables GuardDuty and Security Hub at the org level, delegates admin to security-audit
- **Security-audit account** (`aws.security_audit` provider) -- acts as the delegated administrator for GuardDuty and Security Hub

IAM Access Analyzer runs at the organization level from the management account.

## Key Files

```text
tofu/main.tf        # All resources: GuardDuty, SecurityHub, Access Analyzer + provider requirements
tofu/variables.tf   # Single input: security_audit_account_id
tofu/outputs.tf     # Detector ID, SecurityHub ARN, Access Analyzer ARN
```

## Tech Stack

| Component | Tool | Version |
|-----------|------|---------|
| IaC | OpenTofu | ~> 1.9 |
| Cloud | AWS | ~> 5.0 provider |
| Testing | Go + Terratest | 1.23 |
| Local testing | LocalStack | 4.x |
| CI/CD | GitHub Actions | v4 |
| Task runner | Task | 3.x |
| Tool management | mise | latest |

## Commands

```bash
task setup              # Install tools and git hooks
task tofu:fmt           # Format OpenTofu files
task tofu:validate      # Init and validate configuration
task tofu:tflint        # Run tflint
task test:unit          # Unit tests only
task test:integration   # Integration tests (requires LocalStack)
task ci:validate        # Full CI validation
```

## Development Guidelines

- This is a consumed module -- callers provide their own backend and provider configs
- The `terraform {}` block with `configuration_aliases` lives in `main.tf`
- There is no `versions.tf` -- provider requirements are in `main.tf` to avoid conflicts
- Conventional commits enforced via lefthook
- Use feature branches, create PRs
