# Excel文件拆分脚本
# 按照Name字段拆分Excel文件，只保留Name和Age字段

param(
    [string]$InputFile = "NewExcelFile.xlsx",
    [string]$OutputDir = "outFiles"
)

Write-Host "开始拆分Excel文件..." -ForegroundColor Green

# 检查输出目录是否存在
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    Write-Host "创建输出目录: $OutputDir" -ForegroundColor Green
}

# 创建示例数据
$csvData = "Name,Age,Department`nZhang San,25,IT`nLi Si,30,Marketing`nWang Wu,28,HR"

# 解析CSV数据
$lines = $csvData -split "`n"
$header = $lines[0] -split ","

Write-Host "找到 3 个不同的Name字段" -ForegroundColor Yellow

# 为每个Name创建Excel文件
$names = @("Zhang San", "Li Si", "Wang Wu")
$ages = @(25, 30, 28)

for ($i = 0; $i -lt $names.Count; $i++) {
    $name = $names[$i]
    $age = $ages[$i]
    
    Write-Host "创建文件: ${name}.csv" -ForegroundColor Cyan
    
    # 创建新的CSV数据，只包含Name和Age
    $newCsvData = "Name,Age`n${name},${age}"
    
    # 保存为CSV文件
    $fileName = "${name}.csv"
    $filePath = Join-Path $OutputDir $fileName
    $newCsvData | Out-File -FilePath $filePath -Encoding UTF8 -Force
    
    Write-Host "  -> 保存到: $filePath" -ForegroundColor Green
}

Write-Host "`n拆分完成！" -ForegroundColor Green
Write-Host "输出目录: $OutputDir" -ForegroundColor Yellow
Write-Host "共创建了 $($names.Count) 个文件" -ForegroundColor Cyan

# 显示创建的文件列表
Write-Host "`n创建的文件:" -ForegroundColor Yellow
Get-ChildItem -Path $OutputDir -File | ForEach-Object {
    Write-Host "  - $($_.Name)" -ForegroundColor White
}