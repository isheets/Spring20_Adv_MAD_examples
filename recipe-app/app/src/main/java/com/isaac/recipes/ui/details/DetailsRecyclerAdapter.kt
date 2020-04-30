package com.isaac.recipes.ui.details

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R
import com.isaac.recipes.data.models.DetailRecyclerViewItem

class DetailsRecyclerAdapter(val context: Context, private val detailList: List<DetailRecyclerViewItem>) : RecyclerView.Adapter<DetailsRecyclerAdapter.ViewHolder>() {

    inner class ViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        val mainText: TextView = itemView.findViewById<TextView>(R.id.detailRecyclerMainText)
        val detailText = itemView.findViewById<TextView>(R.id.detailRecyclerDetailText)
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.detail_list_item, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount(): Int = detailList.count()

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val curDetail = detailList[position]

        holder.mainText.text = curDetail.main
        holder.detailText.text = curDetail.detail
    }
}