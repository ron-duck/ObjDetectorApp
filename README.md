# Object Detection Android App

An Android application that uses the device camera to capture photos and perform real-time object detection using TensorFlow Lite.

## Features

- Camera preview with real-time viewfinder
- Photo capture functionality
- Object detection using MobileNet v1 model
- Display detected objects with confidence scores
- Clean, modern Material Design UI

## Setup Instructions

### Prerequisites
- Android Studio Arctic Fox (2020.3.1) or later
- Android SDK 24 (API level 24) or higher
- Device or emulator with camera support

### Installation Steps

1. **Clone or extract the project** to your desired location

2. **Download the TensorFlow Lite model**:
   
   The app uses MobileNet v1 1.0_224 quantized model. You need to download it and place it in the assets folder:
   
   ```bash
   # Navigate to the assets directory
   cd app/src/main/assets/
   
   # Download the model (you can use curl, wget, or download manually)
   curl -L -o mobilenet_v1_1.0_224_quant.tflite https://storage.googleapis.com/download.tensorflow.org/models/mobilenet_v1_1.0_224_quant_and_labels.zip
   
   # If downloading the zip, extract only the .tflite file to assets/
   ```
   
   **Alternative**: You can manually download the model from:
   https://storage.googleapis.com/download.tensorflow.org/models/mobilenet_v1_1.0_224_quant_and_labels.zip
   
   Extract the `mobilenet_v1_1.0_224_quant.tflite` file to `app/src/main/assets/`

3. **Open the project in Android Studio**

4. **Sync the project** to download all dependencies

5. **Build and run** the app on your device or emulator

## Usage

1. **Grant Camera Permission**: When first launching the app, grant camera permission
2. **Point and Capture**: Use the camera preview to frame your subject
3. **Tap Capture**: Press the "Capture Photo" button to take a picture
4. **View Results**: Detected objects will appear below with confidence scores

## Technical Details

### Architecture
- **MainActivity**: Handles camera operations and UI
- **ObjectDetectionService**: TensorFlow Lite integration and model inference
- **DetectionResult**: Data class for detection results
- **DetectionResultAdapter**: RecyclerView adapter for displaying results

### Libraries Used
- **CameraX**: Modern camera API for Android
- **TensorFlow Lite**: On-device machine learning
- **Material Components**: UI components following Material Design
- **ViewBinding**: Type-safe view binding
- **Coroutines**: Asynchronous programming

### Model Information
- **Model**: MobileNet v1 1.0_224 (Quantized)
- **Input Size**: 224x224 pixels
- **Format**: Quantized (8-bit integers)
- **Classes**: 1000+ object categories from ImageNet

## Troubleshooting

### Camera Issues
- Ensure camera permissions are granted
- Check that your device has a working camera
- Try restarting the app if camera preview doesn't appear

### Model Loading Issues
- Verify the model file is in `app/src/main/assets/`
- Check that the file is named exactly `mobilenet_v1_1.0_224_quant.tflite`
- Ensure the file isn't corrupted during download

### Performance
- Object detection runs on the CPU by default
- For better performance, consider using TensorFlow Lite GPU delegate
- Lower resolution images process faster but with potentially lower accuracy

## Customization

### Changing Detection Threshold
Edit the `minConfidenceThreshold` value in `ObjectDetectionService.kt`:

```kotlin
private val minConfidenceThreshold = 0.5f // Adjust between 0.0 and 1.0
```

### Using a Different Model
1. Place your `.tflite` model in the assets folder
2. Update `MODEL_FILE_NAME` in `ObjectDetectionService.kt`
3. Adjust input preprocessing if needed

## License

This project is open source and available under the MIT License.