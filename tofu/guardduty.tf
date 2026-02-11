# --------------------------------------------------------------------------
# GuardDuty - Organization-wide, delegated to security-audit
# --------------------------------------------------------------------------
resource "aws_guardduty_detector" "management" {
  enable = true
}

resource "aws_guardduty_organization_admin_account" "security_audit" {
  admin_account_id = var.security_audit_account_id

  depends_on = [aws_guardduty_detector.management]
}

resource "aws_guardduty_detector" "security_audit" {
  provider = aws.security_audit
  enable   = true
}

resource "aws_guardduty_organization_configuration" "this" {
  provider = aws.security_audit

  auto_enable_organization_members = "ALL"
  detector_id                      = aws_guardduty_detector.security_audit.id

  depends_on = [aws_guardduty_organization_admin_account.security_audit]
}
