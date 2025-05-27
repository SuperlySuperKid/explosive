Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Base URL (change this to match your repo and naming)
$baseUrl = "https://raw.githubusercontent.com/SuperlySuperKid/explosive/main/frame"
$fileExt = ".png"

# Number of frames in your animation
$totalFrames = 5

# Create the form and picture box
$form = New-Object System.Windows.Forms.Form
$form.Text = "Explosive Animation"
$form.ClientSize = New-Object System.Drawing.Size(400,400)
$form.StartPosition = "CenterScreen"

$pb = New-Object System.Windows.Forms.PictureBox
$pb.Dock = "Fill"
$pb.SizeMode = "Zoom"
$form.Controls.Add($pb)

# Timer setup
$index = 1
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 100

$timer.Add_Tick({
    $url = "$baseUrl$index$fileExt"

    try {
        $req = [System.Net.WebRequest]::Create($url)
        $resp = $req.GetResponse()
        $stream = $resp.GetResponseStream()
        $img = [System.Drawing.Image]::FromStream($stream)
        $stream.Close()
        $resp.Close()

        if ($pb.Image) { $pb.Image.Dispose() }
        $pb.Image = $img

        $index = ($index % $totalFrames) + 1
    }
    catch {
        Write-Host "Error loading $url" -ForegroundColor Red
    }
})

$timer.Start()
[void]$form.ShowDialog()
