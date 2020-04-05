package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.isaac.recipes.IMAGE_BASE_URL
import com.isaac.recipes.R
import kotlinx.android.synthetic.main.fragment_recipe_detail.*

/**
 * A simple [Fragment] subclass.
 */
class RecipeDetailFragment : Fragment() {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        //hide the bottom nav since we've moved down in the view hierarchy
        activity?.findViewById<BottomNavigationView>(R.id.nav_view)?.visibility = android.view.View.GONE

        val root = inflater.inflate(R.layout.fragment_recipe_detail, container, false)

        //references to the necessary views
        val ingredientListView = root.findViewById<RecyclerView>(R.id.ingredientsListView)
        val recipeTitleTextView = root.findViewById<TextView>(R.id.recipeTitleTextView)
        val instructionsTextView = root.findViewById<TextView>(R.id.instructionsTextView)
        val imageView = root.findViewById<ImageView>(R.id.recipeImageView)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        //we'll populate the details in this Observer as soon as we get them
        sharedSearchViewModel.recipeDetails.observe(viewLifecycleOwner, Observer {
            Log.i("recipeLogging", "Selected recipe instructions: ${it.extendedIngredients}")

            //get ingredient names
            val ingredientList = mutableListOf<String>()
            for(ingredient in it.extendedIngredients) {
                ingredientList.add(ingredient.originalString)
            }
            //add instantiate and use adapter for recyclerview
            val adapter = IngredientsRecyclerAdapter(requireContext(), ingredientList)
            ingredientListView.adapter = adapter

            //set instructions textview
            instructionsTextView.text = it.instructions
        })

        //we'll use this Observer to set the titles and load the image as soon as we know what recipe we'll be displaying
        sharedSearchViewModel.selectedRecipe.observe(viewLifecycleOwner, Observer{
            //set the title in the action bar
            (activity as AppCompatActivity?)?.supportActionBar?.title = it.title
            //set the title textview
            recipeTitleTextView.text = it.title

            //images can be fetched using the following pattern: https://spoonacular.com/recipeImages/{ID}-{SIZE}.{TYPE}
            Glide.with(this)
                .load("${IMAGE_BASE_URL}/${it.id}-556x370.jpg")
                .into(imageView)
        })

        return root
    }

}
