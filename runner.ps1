while ($true) {
    $frame = Invoke-RestMethod https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame_main.txt
    Write-Host $frame
    Start-Sleep -Milliseconds 100
    Clear-Host
}
