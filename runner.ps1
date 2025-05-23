$frames = @(
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame1.txt",
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame2.txt"
    # Add more URLs here
)

while ($true) {
    foreach ($url in $frames) {
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
