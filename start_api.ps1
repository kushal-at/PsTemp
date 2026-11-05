$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Python = Join-Path $ProjectRoot ".venv\Scripts\python.exe"
$Weights = Join-Path $ProjectRoot "models\FoodSeg103\best_model.pth"
$Labels = Join-Path $ProjectRoot "models\FoodSeg103\labels_config.json"
if (-not (Test-Path -LiteralPath $Python)) { throw "Python environment missing. Follow README.md setup instructions." }
if (-not (Test-Path -LiteralPath $Weights) -or -not (Test-Path -LiteralPath $Labels)) { throw "FoodSeg103 files are missing. Run git lfs pull." }
Set-Location $ProjectRoot
Write-Host "Starting Food Vision API at http://127.0.0.1:8000/docs"
Write-Host "Ollama must be running with qwen3-vl:2b for POST /vision requests."
& $Python -m uvicorn app:app --host 127.0.0.1 --port 8000
exit $LASTEXITCODE
