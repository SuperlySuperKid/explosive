# runner.ps1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 1) List your image frames here (must be raw GitHub URLs to .png/.jpg files)
$frames = @(
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame1.png",
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame2.png",
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame3.png",
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame4.png",
    "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame5.png"
    # …add more as needed
)

# 2) Create WinForms window and PictureBox
$form = New-Object System.Windows.Forms.Form
$form.Text = "Explosive Animation"
$form.ClientSize = New-Object System.Drawing.Size(400,400)
$form.StartPosition = "CenterScreen"

$pb = New-Object System.Windows.Forms.PictureBox
$pb.Dock = "Fill"
$pb.SizeMode = "Zoom"           # Scale to fit
$form.Controls.Add($pb)

# 3) Set up a timer to cycle through frames
$index = 0
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 100           # milliseconds per frame

$timer.Add_Tick({
    try {
        $url = $frames[$index]
        $req = [System.Net.WebRequest]::Create($url)
        $resp = $req.GetResponse()
        $stream = $resp.GetResponseStream()
        $img = [System.Drawing.Image]::FromStream($stream)
        $stream.Close()
        $resp.Close()

        # Assign to PictureBox (disposing old one)
        if ($pb.Image) { $pb.Image.Dispose() }
        $pb.Image = $img

        $index = ($index + 1) % $frames.Count
    }
    catch {
        Write-Host "Error loading $url: $_" -ForegroundColor Red
    }
})

# 4) Start!
$timer.Start()
[void]$form.ShowDialog()
