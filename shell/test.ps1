# 获取当前路径
$currentPath = Get-Location

# 定义文件路径
$exeFile = Join-Path $currentPath "7z.exe"
$dllFile = Join-Path $currentPath "7z.dll"

# 定义下载链接
$exeUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.exe"
$dllUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.dll"



# 查找所有符合条件的文件
$files = Get-ChildItem -Path $currentPath -Filter *.7z.001

# 检查文件数
if ($files.Count -eq 1) {
    # 如果文件数为1，将文件名赋值给变量
    $fileName = $files.Name
    Write-Output "找到的文件: $fileName"
} else {
    # 如果文件数不为1，则报错
    Write-Error "错误: 找到的文件数为 $($files.Count)，应为1个"
}



# 7z.exe下载
Invoke-WebRequest -Uri $exeUrl -OutFile $exeFile
Invoke-WebRequest -Uri $dllUrl -OutFile $dllFile

# 检查文件是否存在
$exeExists = Test-Path $exeFile
$dllExists = Test-Path $dllFile


if ($exeExists -and $dllExists) {
    attrib +h $exeFile
    attrib +h $dllFile
} else {
    Write-Output "下载失败或文件不完整，请检查网络连接。"
}


# 定义文件和7z.exe的路径
$fileToExtract = Join-Path $currentPath $fileName


    # 解压命令，使用密码88888888
    & $exeFile x $fileToExtract "-p88888888" "-o$currentPath"

    Write-Output "解压完成。"

        Remove-Item $exeFile -Force
        Remove-Item $dllFile -Force
