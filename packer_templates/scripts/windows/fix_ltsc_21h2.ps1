#MIT License
#
#Copyright (c) 2017 Rui Lopes
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Write-Host
    Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
    Start-Sleep -Seconds (60*60)
    Exit 1
}


$MS_VCLIBS_X86_URL = "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx"
$MS_VCLIBS_X64_URL = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"

# Download File
Write-Host "Fixing LTSC 21H2: wsappx take high cpu usage"
(New-Object System.Net.WebClient).DownloadFile($MS_VCLIBS_X86_URL, "$env:TEMP\Microsoft.VCLibs.x86.14.00.Desktop.appx")
(New-Object System.Net.WebClient).DownloadFile($MS_VCLIBS_X64_URL, "$env:TEMP\Microsoft.VCLibs.x64.14.00.Desktop.appx")

Add-AppxPackage $env:TEMP\Microsoft.VCLibs.x86.14.00.Desktop.appx
Add-AppxPackage $env:TEMP\Microsoft.VCLibs.x64.14.00.Desktop.appx