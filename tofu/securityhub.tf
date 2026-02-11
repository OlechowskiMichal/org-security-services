# --------------------------------------------------------------------------
# Security Hub - Organization-wide, delegated to security-audit
# --------------------------------------------------------------------------
resource "aws_securityhub_account" "management" {}

resource "aws_securityhub_organization_admin_account" "security_audit" {
  admin_account_id = var.security_audit_account_id

  depends_on = [aws_securityhub_account.management]
}

resource "aws_securityhub_account" "security_audit" {
  provider = aws.security_audit
}

resource "aws_securityhub_organization_configuration" "this" {
  provider = aws.security_audit

  auto_enable = true

  depends_on = [aws_securityhub_organization_admin_account.security_audit]
}
