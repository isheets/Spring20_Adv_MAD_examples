package com.isaac.recipes.ui.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R
import com.isaac.recipes.data.models.Recipe

class RecipeRecyclerAdapter(val context: Context, var recipeList: List<Recipe>, val itemListener: RecipeItemListener) : RecyclerView.Adapter<RecipeRecyclerAdapter.ViewHolder>() {

    //custom ViewHolder
    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val titleText = itemView.findViewById<TextView>(R.id.titleTextView)
        val prepText = itemView.findViewById<TextView>(R.id.prepTextView)
    }

    //inflate the view for the item
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val view = inflater.inflate(R.layout.recipe_list_item, parent, false)
        return ViewHolder(view)
    }

    //number of items in RecyclerView
    override fun getItemCount() = recipeList.count()

    //set the data for the view
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val curRecipe = recipeList[position]

        holder.titleText.text = curRecipe.title
        holder.prepText.text = "${curRecipe.readyInMinutes} min"

        //pass the data item to the fragment click listener
        holder.itemView.setOnClickListener {
            itemListener.onRecipeItemClick(curRecipe)
        }
    }

    interface RecipeItemListener {
        fun onRecipeItemClick(recipe: Recipe)
    }
}