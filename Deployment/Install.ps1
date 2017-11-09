

$adminDLL = "..\Admin\bin\Release\BizTalk.Adapter.SBQueueAdmin.dll";
$receiveDLL = "..\Runtime\bin\Release\BizTalk.Adapter.SBQueue.dll";
$baseAdapterDLL = "..\BaseAdapter\v1.0.2\bin\Release\Microsoft.BizTalk.Adapter.Common.dll";

#Test for 64 bit
$Is64Bit =  [Environment]::Is64BitProcess;

#Install Path
$InstallPath = "C:\Program Files\SBQueueAdapter\";
If($Is64Bit) 
{
    Write-Host "64-bit Process detected."
    $InstallPath = "C:\Program Files (x86)\SBQueueAdapter\"; 
}

#Copy RELEASE version
If((Test-Path $adminDLL) -and (Test-Path $receiveDLL) -and (Test-Path $baseAdapterDLL)) 
{
    Write-Host "Release version of adapter DLL found"
    xcopy /Y $adminDLL $InstallPath
    xcopy /Y $receiveDLL $InstallPath
    xcopy /Y $baseAdapterDLL $InstallPath

    #Registry entries
    Write-Host "Merging registry entries";
    regedit /S .\SBQueueAdapter.reg

    if($Is64Bit) {
        Write-Host "Merging 32-bit on 64-bit registry entries";
        regedit /S .\SBQueueAdapter64.reg
    }


} else {
    Write-Error "Release version of adapter DLL NOT found. Please build the VS project first in RELEASE mode."
}