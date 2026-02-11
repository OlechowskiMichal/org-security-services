# --------------------------------------------------------------------------
# IAM Access Analyzer - Organization-wide
# --------------------------------------------------------------------------
resource "aws_accessanalyzer_analyzer" "organization" {
  analyzer_name = "organization-analyzer"
  type          = "ORGANIZATION"
}
