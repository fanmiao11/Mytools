# 重命名文件
# 在PowerShell中批量修改文件名可以通过多种方法实现，具体取决于你想要如何修改文件名。以下是一些常见的方法：

# 方法1：使用循环和重命名命令

# 如果你想要基于一定的规则来重命名文件，比如给文件添加前缀或后缀，你可以使用Get-ChildItem来获取文件列表，然后使用Rename-Item来重命名。
<#
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

#>


# $files = Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img" -File

# # 示例1：给所有文件添加前缀

# foreach ($file in $files) {
#     Rename-Item -Path $file.FullName -NewName ("prefix_" + $file.Name)
#     Write-Host "✓ 重命名 $file.Name为 prefix_ 在 $bifenPathPC" -ForegroundColor DarkGreen
# }

# # 示例2：给所有文件添加后缀

# foreach ($file in $files) {
#     Rename-Item -Path $file.FullName -NewName ($file.BaseName + "_suffix" + $file.Extension)
# }


# 方法2：使用通配符和重命名命令
# 如果你想要匹配特定模式的文件名并应用规则，可以使用通配符与Rename-Item结合。

# 示例：将所有.txt文件重命名为.md文件

# Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img\*.jpg" | Rename-Item -NewName { $_.BaseName + ".png" }
# Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img\*.png" | Rename-Item -NewName { $_.BaseName + ".jpg" }


# 方法3：使用正则表达式和高级重命名策略
# 对于更复杂的重命名策略，你可以使用正则表达式来匹配文件名，并基于匹配结果进行重命名。

# 示例：将文件名中的“old”替换为“new”
# Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img" | Rename-Item -NewName { $_.Name -replace "suffix", "s" }


# 方法4：使用高级脚本块进行复杂重命名
# 对于非常复杂的重命名需求，你可以在Rename-Item的-NewName参数中使用一个复杂的脚本块。

# 示例：将文件名中的日期格式从YYYYMMDD改为DD-MM-YYYY

# Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img" | Rename-Item -NewName { 
#     $datePart = [DateTime]::ParseExact($_.BaseName.Substring(0, 8), "yyyyMMdd", $null).ToString("dd-MM-yyyy")
#     $newName = $datePart + $_.Extension
#     if ($_.BaseName.Length > 8) {
#         $newName = $datePart + "_" + $_.BaseName.Substring(8) + $_.Extension
#     }
#     $newName 
# }

# 注意：
# 在运行这些命令之前，建议先备份你的文件，以避免不可预见的错误导致数据丢失。
# 确保你有足够的权限来重命名文件，特别是在系统目录或受保护的文件上。
# 在使用正则表达式或复杂的脚本块时，务必测试你的表达式以确保它们按预期工作。可以在PowerShell中先运行表达式的一部分来测试。例如："yourfilename" -replace "old", "new"。
# 通过这些方法，你可以根据需要批量修改文件名。


# $count = $($files.Count)

# while ($count -gt 0) {
#     Write-Output $count
#     $count--
# }

echo "start rename files..."
echo "files count: $($files.Count)"

$files = Get-ChildItem -Path "D:\Desktop\code\Mytools\ToolFiles\addWatermark\img" -Filter "*.jpg"
$count = 1
foreach ($file in $files) {
    # $newName = "{0:D3}.jpg" -f $count
    $newName = "$count.jpg"
    Rename-Item -Path $file.FullName -NewName $newName
    $count++
}

Write-Host "=== end ===" -ForegroundColor Yellow