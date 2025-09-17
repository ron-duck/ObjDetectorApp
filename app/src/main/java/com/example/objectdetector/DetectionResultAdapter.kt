package com.example.objectdetector

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

/**
 * RecyclerView adapter for displaying detection results
 */
class DetectionResultAdapter : RecyclerView.Adapter<DetectionResultAdapter.ViewHolder>() {
    
    private var results: List<DetectionResult> = emptyList()
    
    fun updateResults(newResults: List<DetectionResult>) {
        results = newResults
        notifyDataSetChanged()
    }
    
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_detection_result, parent, false)
        return ViewHolder(view)
    }
    
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(results[position])
    }
    
    override fun getItemCount(): Int = results.size
    
    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val objectNameText: TextView = itemView.findViewById(R.id.objectNameText)
        private val confidenceText: TextView = itemView.findViewById(R.id.confidenceText)
        
        fun bind(result: DetectionResult) {
            objectNameText.text = result.objectName
            confidenceText.text = itemView.context.getString(
                R.string.confidence, 
                result.confidence * 100
            )
        }
    }
}