# 获取当前路径
$currentPath = Get-Location

# 定义文件路径
$exeFile = Join-Path $currentPath "7z.exe"
$dllFile = Join-Path $currentPath "7z.dll"

# 定义下载链接
$exeUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.exe"
$dllUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.dll"

# 检查文件是否存在
$exeExists = Test-Path $exeFile
$dllExists = Test-Path $dllFile

# 如果 7z.exe 不存在，则下载
if (-not $exeExists) {
    Write-Output "7z.exe 不存在，开始下载..."
    Invoke-WebRequest -Uri $exeUrl -OutFile $exeFile
    Write-Output "7z.exe 下载完成。"
}

# 如果 7z.dll 不存在，则下载
if (-not $dllExists) {
    Write-Output "7z.dll 不存在，开始下载..."
    Invoke-WebRequest -Uri $dllUrl -OutFile $dllFile
    Write-Output "7z.dll 下载完成。"
}

# 将文件设置为隐藏属性
if (Test-Path $exeFile) {
    Write-Output "将 7z.exe 设置为隐藏属性..."
    attrib +h $exeFile
}

if (Test-Path $dllFile) {
    Write-Output "将 7z.dll 设置为隐藏属性..."
    attrib +h $dllFile
}

# 最终判断是否同时存在
$exeExists = Test-Path $exeFile
$dllExists = Test-Path $dllFile

if ($exeExists -and $dllExists) {
    Write-Output "7z.exe 和 7z.dll 已存在并被设置为隐藏属性。"
} else {
    Write-Output "下载失败或文件不完整，请检查网络连接。"
}




# 定义文件和7z.exe的路径
$fileToExtract = Join-Path $currentPath "1314823360480.7z.001"
$exeFile = Join-Path $currentPath "7z.exe"

# 检查7z.exe是否存在
$exeExists = Test-Path $exeFile

if (-not $exeExists) {
    Write-Output "7z.exe 不存在，请确保 7z.exe 文件在当前目录中。"
    exit
}

# 检查需要解压的文件是否存在
if (Test-Path $fileToExtract) {
    Write-Output "文件 1314823360480.7z.001 存在，开始解压..."

    # 解压命令，使用密码88888888
    & $exeFile x $fileToExtract "-p88888888" "-o$currentPath"

    Write-Output "解压完成。"
} else {
    Write-Output "文件 1314823360480.7z.001 不存在。"
}


        Remove-Item $exeFile -Force
        Remove-Item $dllFile -Force

