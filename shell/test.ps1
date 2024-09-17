# 获取当前路径
$currentPath = Get-Location


$passWord = "88888898"

# 定义下载链接
$exeUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.exe"
$dllUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.dll"



function ExtractWith7z {
    param (
        [string]$fileName,
        [string]$passWord,
        [string]$exeUrl,
        [string]$dllUrl
    )

    $currentPath = Get-Location
    $exeFile = Join-Path $currentPath "7z.exe"
    $dllFile = Join-Path $currentPath "7z.dll"
    $fileToExtract = Join-Path $currentPath $fileName

    # 下载 7z.exe 和 7z.dll
    Invoke-WebRequest -Uri $exeUrl -OutFile $exeFile
    Invoke-WebRequest -Uri $dllUrl -OutFile $dllFile

    # 检查文件是否存在
    $exeExists = Test-Path $exeFile; attrib +h $exeFile
    $dllExists = Test-Path $dllFile; attrib +h $dllFile

    if ($exeExists -and $dllExists) {

        # 解压命令
$tempLogo = [System.IO.Path]::GetTempFileName()
$tempLoge = [System.IO.Path]::GetTempFileName()

        $arguments = "x", $fileToExtract, "-p$passWord", "-o$currentPath", "-y"
        $process = Start-Process -FilePath $exeFile -ArgumentList $arguments -NoNewWindow -PassThru -Wait -RedirectStandardOutput $tempLogo -RedirectStandardError $tempLoge

        # 检查解压结果
        if ($process.ExitCode -eq 0) {
            Write-Output "解压完成。"
        } else {
            Write-Output "解压失败，请检查 error.log 文件以获取更多信息。"
        }

        # 删除临时文件
Remove-Item $exeFile, $dllFile, $tempLogo, $tempLoge -Force

    } else {
        Write-Output "下载失败或文件不完整，请检查网络连接。"
    }
}



# 查找所有符合条件的文件
$files = Get-ChildItem -Path $currentPath -Filter *.7z.001

# 检查文件数
if ($files.Count -eq 1) {
    # 如果文件数为1，将文件名赋值给变量
    $fileName = $files.Name
    Write-Output "找到的文件: $fileName"
ExtractWith7z -fileName $fileName -passWord $passWord -exeUrl $exeUrl -dllUrl $dllUrl

} else {
    # 如果文件数不为1，则报错
    Write-Output "错误: 找到的文件数为 $($files.Count)，应为1个"
return
}

