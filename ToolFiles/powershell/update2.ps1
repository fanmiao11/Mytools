for ($number = 1; $number -le 100; $number++) {

    $rootP = "D:\work\tplhub\tplhub\"
    $path = "ty-qmb"
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

    Write-Host ">>> 开始复制 ..." -ForegroundColor Cyan

    # ========== 新增：删除 pc & mobile football 目录 ==========
    # $pcFootballPath = "$targetBase/pc/views/football"
    # $mobileFootballPath = "$targetBase/mobile/views/football"

    # if (Test-Path $pcFootballPath) {
    #     Remove-Item $pcFootballPath -Recurse -Force
    #     Write-Host "✓ 已删除目录：$pcFootballPath" -ForegroundColor DarkGreen
    # } else {
    #     Write-Host "× 未找到目录：$pcFootballPath" -ForegroundColor DarkYellow
    # }

    # if (Test-Path $mobileFootballPath) {
    #     Remove-Item $mobileFootballPath -Recurse -Force
    #     Write-Host "✓ 已删除目录：$mobileFootballPath" -ForegroundColor DarkGreen
    # } else {
    #     Write-Host "× 未找到目录：$mobileFootballPath" -ForegroundColor DarkYellow
    # }

    # # ========== 复制 mobile 端 live{number} ==========
    $srcScssMobile = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/scss/bf.scss"
    $srcCssMobile  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/css/bf.min.css"

    if (Test-Path $srcScssMobile) {
        Copy-Item $srcScssMobile "$targetBase/mobile/statics/scss" -Force
    } else {
        Write-Host "× 缺少 $srcScssMobile" -ForegroundColor Red
    }

    if (Test-Path $srcCssMobile) {
        Copy-Item $srcCssMobile "$targetBase/mobile/statics/css" -Force
    } else {
        Write-Host "× 缺少 $srcCssMobile" -ForegroundColor Red
    }

    # ========== 复制 mobile 端 js ==========
    $srcBfJsMobile = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/bf.js"
    $srcBfJsMinMobile  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/bf.min.js"

    if (Test-Path $srcBfJsMobile) {
        Copy-Item $srcBfJsMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBfJsMobile" -ForegroundColor Red
    }

    if (Test-Path $srcBfJsMinMobile) {
        Copy-Item $srcBfJsMinMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBfJsMinMobile" -ForegroundColor Red
    }

    $srcBf2JsMobile = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/bf2.js"
    $srcBf2JsMinMobile  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/bf2.min.js"

    if (Test-Path $srcBf2JsMobile) {
        Copy-Item $srcBf2JsMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBf2JsMobile" -ForegroundColor Red
    }

    if (Test-Path $srcBf2JsMinMobile) {
        Copy-Item $srcBf2JsMinMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBf2JsMinMobile" -ForegroundColor Red
    }

    $srcComJsMobile = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/com.js"
    $srcComJsMinMobile  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/statics/js/com.min.js"

    if (Test-Path $srcComJsMobile) {
        Copy-Item $srcComJsMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcComJsMobile" -ForegroundColor Red
    }

    if (Test-Path $srcComJsMinMobile) {
        Copy-Item $srcComJsMinMobile "$targetBase/mobile/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcComJsMinMobile" -ForegroundColor Red
    }

    # ========== 复制 mobile 端 bifen目录 ==========
    $srcBfPathMobile = "D:\work\tplhub\tplhub\hy-ty-qmb-06/mobile/views/bifen"

    if (Test-Path $srcBfPathMobile) {
        Copy-Item $srcBfPathMobile "$targetBase/mobile/views" -Recurse -Force
    } else {
        Write-Host "× 缺少 $srcBfPathMobile" -ForegroundColor Red
    }


    # ========== 复制 pc 端 live{number} ==========
    $srcScssPC = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/scss/bf.scss"
    $srcCssPC  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/css/bf.min.css"

    if (Test-Path $srcScssPC) {
        Copy-Item $srcScssPC "$targetBase/pc/statics/scss" -Force
    } else {
        Write-Host "× 缺少 $srcScssPC" -ForegroundColor Red
    }

    if (Test-Path $srcCssPC) {
        Copy-Item $srcCssPC "$targetBase/pc/statics/css" -Force
    } else {
        Write-Host "× 缺少 $srcCssPC" -ForegroundColor Red
    }

    # ========== 先删除 pc 端旧的 bf.js 和 bf.min.js ==========
    $targetBfJsPC      = "$targetBase/pc/statics/js/bf.js"
    $targetBfJsMinPC   = "$targetBase/pc/statics/js/bf.min.js"

    if (Test-Path $targetBfJsPC) {
        Remove-Item $targetBfJsPC -Force
        Write-Host "✓ 已删除：$targetBfJsPC" -ForegroundColor DarkGreen
    } else {
        Write-Host "× 未找到：$targetBfJsPC" -ForegroundColor DarkYellow
    }

    if (Test-Path $targetBfJsMinPC) {
        Remove-Item $targetBfJsMinPC -Force
        Write-Host "✓ 已删除：$targetBfJsMinPC" -ForegroundColor DarkGreen
    } else {
        Write-Host "× 未找到：$targetBfJsMinPC" -ForegroundColor DarkYellow
    }

    # ========== 复制 pc 端 js ==========
    $srcBfJsPC = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/js/bfpc.js"
    $srcBfJsMinPC  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/js/bfpc.min.js"

    if (Test-Path $srcBfJsPC) {
        Copy-Item $srcBfJsPC "$targetBase/pc/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBfJsPC" -ForegroundColor Red
    }

    if (Test-Path $srcBfJsMinPC) {
        Copy-Item $srcBfJsMinPC "$targetBase/pc/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcBfJsMinPC" -ForegroundColor Red
    }

    $srcComJsPC = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/js/com.js"
    $srcComJsMinPC  = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/statics/js/com.min.js"

    if (Test-Path $srcComJsPC) {
        Copy-Item $srcComJsPC "$targetBase/pc/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcComJsPC" -ForegroundColor Red
    }

    if (Test-Path $srcComJsMinPC) {
        Copy-Item $srcComJsMinPC "$targetBase/pc/statics/js" -Force
    } else {
        Write-Host "× 缺少 $srcComJsMinPC" -ForegroundColor Red
    }

    # ========== 复制 pc 端 bifen目录 ==========
    $srcBfPathPC = "D:\work\tplhub\tplhub\hy-ty-qmb-06/pc/views/bifen"

    if (Test-Path $srcBfPathPC) {
        Copy-Item $srcBfPathPC "$targetBase/pc/views" -Recurse -Force
    } else {
        Write-Host "× 缺少 $srcBfPathPC" -ForegroundColor Red
    }



    # ========== 复制固定文件 live2（所有站点） ==========
    # Copy-Item "E:/project/GIT/tplhub/hy-test-tp/pc/statics/css/livepc.min.css" "$targetBase/pc/statics/css" -Force
    # Copy-Item "E:/project/GIT/tplhub/hy-test-tp/pc/statics/scss/livepc.scss"     "$targetBase/pc/statics/scss" -Force

    Write-Host ">>> ty-qmb-$number 复制完成！`n" -ForegroundColor Green
}

Write-Host "=== 所有站点复制操作完成 ===" -ForegroundColor Yellow
