package com.example.objectdetector

import android.content.Context
import android.graphics.Bitmap
import android.util.Log
import org.tensorflow.lite.support.image.TensorImage
import org.tensorflow.lite.task.vision.detector.Detection
import org.tensorflow.lite.task.vision.detector.ObjectDetector
import java.io.IOException

/**
 * Service for performing object detection using TensorFlow Lite
 */
class ObjectDetectionService(private val context: Context) {
    
    private var objectDetector: ObjectDetector? = null
    private val minConfidenceThreshold = 0.5f
    
    companion object {
        private const val TAG = "ObjectDetectionService"
        private const val MODEL_FILE_NAME = "mobilenet_v1_1.0_224_quant.tflite"
    }
    
    /**
     * Initialize the object detector
     */
    fun initialize(): Boolean {
        return try {
            val options = ObjectDetector.ObjectDetectorOptions.builder()
                .setScoreThreshold(minConfidenceThreshold)
                .setMaxResults(10)
                .build()
            
            objectDetector = ObjectDetector.createFromFileAndOptions(
                context,
                MODEL_FILE_NAME,
                options
            )
            
            Log.d(TAG, "Object detector initialized successfully")
            true
        } catch (e: IOException) {
            Log.e(TAG, "Failed to initialize object detector", e)
            false
        }
    }
    
    /**
     * Detect objects in the given bitmap
     */
    fun detectObjects(bitmap: Bitmap): List<DetectionResult> {
        val detector = objectDetector ?: return emptyList()
        
        return try {
            val tensorImage = TensorImage.fromBitmap(bitmap)
            val detections = detector.detect(tensorImage)
            
            detections.map { detection ->
                val category = detection.categories.firstOrNull()
                DetectionResult(
                    objectName = category?.label ?: "Unknown",
                    confidence = category?.score ?: 0f,
                    boundingBox = detection.boundingBox?.let { bbox ->
                        RectF(
                            left = bbox.left,
                            top = bbox.top,
                            right = bbox.right,
                            bottom = bbox.bottom
                        )
                    }
                )
            }.filter { it.confidence >= minConfidenceThreshold }
                .sortedByDescending { it.confidence }
            
        } catch (e: Exception) {
            Log.e(TAG, "Error detecting objects", e)
            emptyList()
        }
    }
    
    /**
     * Release resources
     */
    fun close() {
        objectDetector?.close()
        objectDetector = null
    }
}