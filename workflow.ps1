Write-Host "=== FA1 Demo: Git-Based IaC Multi-Environment Deployment ===" -ForegroundColor Cyan

Write-Host "`n[1] Checking Docker is running..." -ForegroundColor Yellow
docker ps

Write-Host "`n[2] Project structure:" -ForegroundColor Yellow
Get-ChildItem -Recurse -Depth 2 -Path .\project | Select-Object FullName

Write-Host "`n[3] Deploying QA environment..." -ForegroundColor Yellow
cd terraform
terraform apply -var-file="environments/qa.tfvars" -auto-approve

Write-Host "`n[4] Deploying UAT environment (same code, different tfvars)..." -ForegroundColor Yellow
terraform apply -var-file="environments/uat.tfvars" -auto-approve

Write-Host "`n[5] Deploying PROD environment..." -ForegroundColor Yellow
terraform apply -var-file="environments/prod.tfvars" -auto-approve

Write-Host "`n[6] All containers running across environments:" -ForegroundColor Yellow
docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}"

Write-Host "`n[7] Hitting each environment's backend:" -ForegroundColor Yellow
Invoke-RestMethod http://localhost:5001
Invoke-RestMethod http://localhost:5011
Invoke-RestMethod http://localhost:5021

Write-Host "`n=== Demo complete ===" -ForegroundColor Green