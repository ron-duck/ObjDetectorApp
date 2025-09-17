# PowerShell script to find and copy your Object Detector APK

Write-Host "🔍 Looking for Object Detector APKs..." -ForegroundColor Green

$debugApk = "app\build\outputs\apk\debug\app-debug.apk"
$releaseApk = "app\build\outputs\apk\release\app-release-unsigned.apk"
$desktopPath = [Environment]::GetFolderPath("Desktop")

Write-Host "`n📂 Checking APK locations:" -ForegroundColor Yellow

# Check for Debug APK
if (Test-Path $debugApk) {
    $debugInfo = Get-Item $debugApk
    Write-Host "✅ DEBUG APK FOUND!" -ForegroundColor Green
    Write-Host "   📍 Location: $((Get-Location).Path)\$debugApk" -ForegroundColor Cyan
    Write-Host "   📏 Size: $([math]::Round($debugInfo.Length / 1MB, 2)) MB" -ForegroundColor Cyan
    Write-Host "   📅 Modified: $($debugInfo.LastWriteTime)" -ForegroundColor Cyan
    
    # Copy to desktop
    $desktopApk = "$desktopPath\ObjectDetector-Debug.apk"
    Copy-Item $debugApk $desktopApk -Force
    Write-Host "   📋 Copied to Desktop: ObjectDetector-Debug.apk" -ForegroundColor Green
} else {
    Write-Host "❌ Debug APK not found at: $debugApk" -ForegroundColor Red
}

Write-Host ""

# Check for Release APK
if (Test-Path $releaseApk) {
    $releaseInfo = Get-Item $releaseApk
    Write-Host "✅ RELEASE APK FOUND!" -ForegroundColor Green
    Write-Host "   📍 Location: $((Get-Location).Path)\$releaseApk" -ForegroundColor Cyan
    Write-Host "   📏 Size: $([math]::Round($releaseInfo.Length / 1MB, 2)) MB" -ForegroundColor Cyan
    Write-Host "   📅 Modified: $($releaseInfo.LastWriteTime)" -ForegroundColor Cyan
    
    # Copy to desktop
    $desktopApk = "$desktopPath\ObjectDetector-Release.apk"
    Copy-Item $releaseApk $desktopApk -Force
    Write-Host "   📋 Copied to Desktop: ObjectDetector-Release.apk" -ForegroundColor Green
} else {
    Write-Host "❌ Release APK not found at: $releaseApk" -ForegroundColor Red
}

if (!(Test-Path $debugApk) -and !(Test-Path $releaseApk)) {
    Write-Host "`n🔨 No APKs found. Build your app first:" -ForegroundColor Yellow
    Write-Host "   1. In Android Studio: Build → Build Bundle(s)/APK(s) → Build APK(s)" -ForegroundColor White
    Write-Host "   2. Or run: ./gradlew assembleDebug" -ForegroundColor White
    Write-Host "   3. Then run this script again!" -ForegroundColor White
}

Write-Host "`n📱 How to install on your phone:" -ForegroundColor Yellow
Write-Host "   1. Enable 'Developer Options' and 'USB Debugging'" -ForegroundColor White
Write-Host "   2. Copy APK to phone via USB/email/cloud" -ForegroundColor White
Write-Host "   3. Enable 'Install from unknown sources'" -ForegroundColor White
Write-Host "   4. Tap the APK file to install" -ForegroundColor White

Write-Host "`nPress any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")