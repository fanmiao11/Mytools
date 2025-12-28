# ToolFiles
1.addWatermark 图片添加水印 运行：node index.js

2.jsMin 
转译es5代码及压缩js 修改对应目录并运行：npx gulp

3.siteScripts 后台站点管理脚本 node 对应js
- newDealSites.js  处理域名分组
- newAddSites.js  新建站点
- newAddDomainsJH.js  新建域名/关联域名
- newChangeTemplate.js  修改站点模板
- newSetTDK.js  生成站点TDK
- newSiteConfig.js  设置站点配置
- permutation.js 生成关键词

4.powerShell 在终端直接cd到文件所在目录
- rename.ps1 重命名脚本 pwsh rename.ps1
- update2.ps1 批量复制文件脚本 执行 pwsh update2.ps1
- update.ps1 弃用
- updateCss.sh 批量修改css文件名 shell updateCss.sh

PowerShell 脚本需要通过右键菜单选择“使用 PowerShell”运行。

执行策略：Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

可以参考 https://www.runoob.com/powershell/powershell-core.html


## 运行 .ps1 文件的核心是调整 PowerShell 执行策略后通过命令行或工具调用，以下是具体方法：

### 🔧 第一步：调整执行策略（必须操作）
PowerShell 默认禁止运行脚本，需先修改策略：

以管理员身份打开 PowerShell（右键开始菜单选择）。
输入命令查看当前策略：Get-ExecutionPolicy（若显示 Restricted 则需修改）。‌‌

输入命令放宽策略（二选一）：
Set-ExecutionPolicy RemoteSigned：允许本地脚本运行，但需签名下载的脚本（推荐）。‌‌

Set-ExecutionPolicy Bypass：完全跳过限制（仅临时使用）。‌‌

### 🚀 第二步：运行脚本的 3 种方法
根据场景选择：

‌直接调用（推荐简单脚本）‌。
在 PowerShell 中输入：
& "C:\路径\脚本名.ps1"
>  D:\Desktop\code\Mytools\ToolFiles\powershell\renames.ps1
路径含空格时用双引号包裹。‌‌

‌命令行运行（适合带参数脚本）‌。
在 CMD 或 PowerShell 中输入：
powershell -File "C:\路径\脚本名.ps1" 参数1 参数2
-File 指定脚本路径，后接参数。‌‌

‌用 PowerShell ISE 运行（可视化操作）‌。
打开 Windows PowerShell ISE（开始菜单搜索）。
点击菜单栏“文件” > 打开脚本，按 F5 运行。‌‌

 ### ⚙️ 常见问题解决
‌报错“无法加载文件”‌：检查路径是否含中文/空格，改用简单路径如 C:\scripts\test.ps1。‌‌

‌提示“权限不足”‌：始终以管理员身份运行 PowerShell。‌‌

‌签名错误‌：临时绕过策略：Set-ExecutionPolicy Bypass -Scope Process（仅当前会话）