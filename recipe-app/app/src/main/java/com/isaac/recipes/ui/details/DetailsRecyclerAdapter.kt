package com.isaac.recipes.ui.details

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R

class DetailsRecyclerAdapter(val context: Context, val ingredientList: List<String>) : RecyclerView.Adapter<DetailsRecyclerAdapter.ViewHolder>() {

    inner class ViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
        val ingredientTextView: TextView = itemView.findViewById<TextView>(R.id.ingredientTextView)
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.ingredient_list_item, parent, false)
        return ViewHolder(view)
    }

    override fun getItemCount(): Int = ingredientList.count()

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val curIngredient = ingredientList[position]

        holder.ingredientTextView.text = curIngredient
    }
}