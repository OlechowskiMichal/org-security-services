# org-security-services

Organization-wide security services: GuardDuty, Security Hub, and IAM Access Analyzer — delegated to a security-audit account.

## Usage

```hcl
module "security_services" {
  source = "git::https://github.com/OlechowskiMichal/org-security-services.git//tofu?ref=v1.0.0"

  security_audit_account_id = aws_organizations_account.this["security-audit"].id

  providers = {
    aws                = aws
    aws.security_audit = aws.security_audit
  }
}
```

## Resources Created

- GuardDuty detector (management + security-audit)
- GuardDuty organization admin delegation
- GuardDuty organization configuration (auto-enable all members)
- Security Hub account (management + security-audit)
- Security Hub organization admin delegation
- Security Hub organization configuration (auto-enable)
- IAM Access Analyzer (organization-wide)

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| security_audit_account_id | Security-audit account ID | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| guardduty_detector_id | GuardDuty detector ID in security-audit |
| securityhub_arn | Security Hub ARN in security-audit |
| access_analyzer_arn | IAM Access Analyzer ARN |

## Providers

Requires two AWS provider configurations:

- `aws` — management account (default)
- `aws.security_audit` — security-audit account
