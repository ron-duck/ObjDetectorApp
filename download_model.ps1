# PowerShell script to download the MobileNet v1 model for object detection

Write-Host "Downloading TensorFlow Lite MobileNet v1 model..." -ForegroundColor Green

# Create assets directory if it doesn't exist
$assetsDir = "app/src/main/assets"
if (!(Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir -Force
    Write-Host "Created assets directory: $assetsDir" -ForegroundColor Yellow
}

# Download URL for the model
$modelUrl = "https://storage.googleapis.com/download.tensorflow.org/models/mobilenet_v1_1.0_224_quant_and_labels.zip"
$zipFile = "mobilenet_model.zip"
$modelFile = "mobilenet_v1_1.0_224_quant.tflite"

try {
    # Download the model zip file
    Write-Host "Downloading model from: $modelUrl" -ForegroundColor Cyan
    Invoke-WebRequest -Uri $modelUrl -OutFile $zipFile
    
    # Extract the model file
    Write-Host "Extracting model file..." -ForegroundColor Cyan
    Expand-Archive -Path $zipFile -DestinationPath "temp_extract" -Force
    
    # Move the model file to assets directory
    $extractedModel = "temp_extract/$modelFile"
    if (Test-Path $extractedModel) {
        Move-Item $extractedModel "$assetsDir/$modelFile" -Force
        Write-Host "Model successfully placed in: $assetsDir/$modelFile" -ForegroundColor Green
    } else {
        Write-Host "Error: Model file not found in the extracted archive" -ForegroundColor Red
        Get-ChildItem "temp_extract" | ForEach-Object { Write-Host "Found: $($_.Name)" }
    }
    
    # Cleanup
    Remove-Item $zipFile -Force -ErrorAction SilentlyContinue
    Remove-Item "temp_extract" -Recurse -Force -ErrorAction SilentlyContinue
    
    Write-Host "Model download completed successfully!" -ForegroundColor Green
    Write-Host "You can now build and run the Android app." -ForegroundColor Yellow
    
} catch {
    Write-Host "Error downloading model: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Please try downloading manually from: $modelUrl" -ForegroundColor Yellow
}

Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")