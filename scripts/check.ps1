# scripts/check.ps1
# Run lint and tests locally before pushing
#
# Usage:
#   Fill in <LINT_COMMAND> and <TEST_COMMAND> for your stack, then run:
#   .\scripts\check.ps1

Write-Host "=== Lint ===" -ForegroundColor Cyan
<LINT_COMMAND>
if ($LASTEXITCODE -ne 0) {
    Write-Host "[FAILED] Lint errors found." -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Test ===" -ForegroundColor Cyan
<TEST_COMMAND>
if ($LASTEXITCODE -ne 0) {
    Write-Host "[FAILED] Tests failed." -ForegroundColor Red
    exit 1
}

Write-Host "`n[OK] All checks passed." -ForegroundColor Green