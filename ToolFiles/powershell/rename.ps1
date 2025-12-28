for ($number = 1; $number -le 6; $number++) {

    $rootP = "/Users/yys/work/project/GIT/tplhub/"
    $path = "hy-ty-qmb"
    $targetBase = "$rootP$path"
    if ($number -eq 1) {
    }
    elseif ($number -lt 10) {
        $targetBase = "$rootP$path-0$number"
    }
    else {
        $targetBase = "$rootP$path-$number"
    }

    if (!(Test-Path $targetBase)) {
        Write-Host "!!! 跳过 ty-qmb-$number，目录不存在" -ForegroundColor DarkYellow
        continue
    }

    Write-Host ">>> 开始执行 ..." -ForegroundColor Cyan

    # ========== 重命名 bifen 目录下的 HTML 文件 ==========
    $bifenPathPC = "$targetBase/pc/views/bifen"
    $bifenPathMobile = "$targetBase/mobile/views/bifen"

    # 处理 PC 端
    if (Test-Path $bifenPathPC) {
        # 检查并重命名文件
        $endHtmlPC = "$bifenPathPC/end.html"
        $scheduleHtmlPC = "$bifenPathPC/schedule.html"
        if (Test-Path $endHtmlPC) {
            Rename-Item $endHtmlPC -NewName "wc.html"
            Write-Host "✓ 重命名 end.html 为 wc.html 在 $bifenPathPC" -ForegroundColor DarkGreen
        } else {
            Write-Host "× 未找到 end.html 在 $bifenPathPC" -ForegroundColor DarkYellow
        }

        if (Test-Path $scheduleHtmlPC) {
            Rename-Item $scheduleHtmlPC -NewName "sc.html"
            Write-Host "✓ 重命名 schedule.html 为 sc.html 在 $bifenPathPC" -ForegroundColor DarkGreen
        } else {
            Write-Host "× 未找到 schedule.html 在 $bifenPathPC" -ForegroundColor DarkYellow
        }
    } else {
        Write-Host "× 未找到目录：$bifenPathPC" -ForegroundColor DarkYellow
    }

    # 处理 mobile 端
    if (Test-Path $bifenPathMobile) {
        # 检查并重命名文件
        $endHtmlMobile = "$bifenPathMobile/end.html"
        $scheduleHtmlMobile = "$bifenPathMobile/schedule.html"
        if (Test-Path $endHtmlMobile) {
            Rename-Item $endHtmlMobile -NewName "wc.html"
            Write-Host "✓ 重命名 end.html 为 wc.html 在 $bifenPathMobile" -ForegroundColor DarkGreen
        } else {
            Write-Host "× 未找到 end.html 在 $bifenPathMobile" -ForegroundColor DarkYellow
        }

        if (Test-Path $scheduleHtmlMobile) {
            Rename-Item $scheduleHtmlMobile -NewName "sc.html"
            Write-Host "✓ 重命名 schedule.html 为 sc.html 在 $bifenPathMobile" -ForegroundColor DarkGreen
        } else {
            Write-Host "× 未找到 schedule.html 在 $bifenPathMobile" -ForegroundColor DarkYellow
        }
    } else {
        Write-Host "× 未找到目录：$bifenPathMobile" -ForegroundColor DarkYellow
    }


    Write-Host ">>> ty-qmb-$number 操作完成！`n" -ForegroundColor Green
}

Write-Host "=== 所有站点操作完成 ===" -ForegroundColor Yellow
