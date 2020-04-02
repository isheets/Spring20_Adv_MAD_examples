package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.isaac.recipes.R

/**
 * A simple [Fragment] subclass.
 */
class RecipeDetailFragment : Fragment() {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        sharedSearchViewModel.selectedRecipe.observe(viewLifecycleOwner, Observer{
            Log.i("recipeLogging", "Selected recipe: ${it.title}")
        })

        sharedSearchViewModel.recipeDetails.observe(viewLifecycleOwner, Observer {
            Log.i("recipeLogging", "Selected recipe instructions: ${it.instructions}")
        })

        return inflater.inflate(R.layout.fragment_recipe_detail, container, false)
    }

}
