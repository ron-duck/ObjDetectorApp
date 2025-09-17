package com.example.objectdetector

/**
 * Data class representing a detected object
 */
data class DetectionResult(
    val objectName: String,
    val confidence: Float,
    val boundingBox: RectF? = null
) {
    override fun toString(): String {
        return "$objectName (${String.format("%.1f", confidence * 100)}%)"
    }
}

/**
 * Simple rectangle class for bounding boxes
 */
data class RectF(
    val left: Float,
    val top: Float,
    val right: Float,
    val bottom: Float
)