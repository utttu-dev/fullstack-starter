# scripts/reset-docker.ps1
# Full reset for Docker cache issues.
# Use this when code changes don't seem to be reflected in containers.
#
# Usage:
#   .\scripts\reset-docker.ps1

Write-Host "=== Removing containers and volumes ===" -ForegroundColor Cyan
docker compose -f docker/docker-compose.yml down -v

Write-Host "`n=== Rebuilding without cache ===" -ForegroundColor Cyan
docker compose -f docker/docker-compose.yml build --no-cache

Write-Host "`n=== Starting containers ===" -ForegroundColor Cyan
docker compose -f docker/docker-compose.yml up -d

Write-Host "`n=== Running database migrations (if applicable) ===" -ForegroundColor Cyan
Start-Sleep -Seconds 5
<MIGRATION_COMMAND>

Write-Host "`n=== Health check ===" -ForegroundColor Cyan
$health = Invoke-WebRequest http://localhost:<BACKEND_PORT>/health -UseBasicParsing
Write-Host $health.Content

Write-Host "`n[OK] Docker reset complete." -ForegroundColor Green