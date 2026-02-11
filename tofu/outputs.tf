output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector in security-audit"
  value       = aws_guardduty_detector.security_audit.id
}

output "securityhub_arn" {
  description = "The ARN of the Security Hub account in security-audit"
  value       = aws_securityhub_account.security_audit.arn
}

output "access_analyzer_arn" {
  description = "The ARN of the IAM Access Analyzer"
  value       = aws_accessanalyzer_analyzer.organization.arn
}
