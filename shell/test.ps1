# 获取当前路径
$currentPath = Get-Location

# 定义文件路径
$exeFile = Join-Path $currentPath "7z.exe"
$dllFile = Join-Path $currentPath "7z.dll"

# 定义下载链接
$exeUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.exe"
$dllUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.dll"


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
$fileToExtract = Join-Path $currentPath "1314823360480.7z.001"


# 检查需要解压的文件是否存在
if (Test-Path $fileToExtract) {
    Write-Output "文件 1314823360480.7z.001 存在，开始解压..."

    # 解压命令，使用密码88888888
    & $exeFile x $fileToExtract "-p88888888" "-o$currentPath"

    Write-Output "解压完成。"

        Remove-Item $exeFile -Force
        Remove-Item $dllFile -Force

} else {
    Write-Output "文件 1314823360480.7z.001 不存在。"
}



