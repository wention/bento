

Add-WindowsCapability -Online -Name $((Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH.Server*").Name)

Stop-Service -Name "sshd"
Set-Service -Name "sshd" -StartupType "Automatic"
Start-Service -Name "sshd"

