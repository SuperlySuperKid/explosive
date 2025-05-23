while ($true) {
    for ($i = 1; $i -le 2; $i++) {
        $url = "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame$($i).txt"
        try {
            $frame = Invoke-RestMethod $url
            Write-Host $frame
        } catch {
            Write-Host "Error loading $url"
        }
        Start-Sleep -Milliseconds 100
        Clear-Host
    }
}
