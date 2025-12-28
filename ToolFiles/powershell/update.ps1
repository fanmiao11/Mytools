# powershell -ExecutionPolicy Bypass -File .\update.ps1
for ($i = 1; $i -le 6; $i++) {

    $rootP = "/Desktop/tplhub/"
    $path = "hy-ty-qmb"
    $target = "$rootP$path"
    if ($i -eq 1) {
    }
    elseif ($i -lt 10) {
        $target = "$rootP$path-0$i"
    }
    else {
        $target = "$rootP$path-$i"
    }

    # $target = "D:\Desktop\tplhub\hy-ty-qmb-0$i"

    Write-Host ">>> 正在更新 $target ..." -ForegroundColor Cyan

    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\views\yuce" "$target\mobile\views" -Recurse -Force
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\views\yuce" "$target\pc\views" -Recurse -Force

    Copy-Item "D:\Desktop\tplhub\hy-test-tp\mobile\statics\css\analyst-mobile.min.css" "$target\mobile\statics\css" -Recurse -Force
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\statics\css\analyst-pc.min.css" "$target\pc\statics\css" -Recurse -Force
    
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\mobile\statics\scss\analyst-mobile.scss" "$target\mobile\statics\scss" -Recurse -Force
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\statics\scss\analyst-pc.scss" "$target\pc\statics\scss" -Recurse -Force
    
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\statics\js\analyst.js" "$target\mobile\statics\js" -Recurse -Force
    Copy-Item "D:\Desktop\tplhub\hy-test-tp\pc\statics\js\analyst.js" "$target\pc\statics\js" -Recurse -Force




    Write-Host ">>> $target 更新完成。`n" -ForegroundColor Green
}

Write-Host "=== 全部 12~100 已更新完成 ===" -ForegroundColor Yellow
