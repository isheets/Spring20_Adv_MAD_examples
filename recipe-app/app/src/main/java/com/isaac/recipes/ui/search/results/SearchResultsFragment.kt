package com.isaac.recipes.ui.search.results

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.R
import com.isaac.recipes.data.Recipe
import com.isaac.recipes.ui.search.SharedSearchViewModel

/**
 * A simple [Fragment] subclass.
 */
class SearchResultsFragment : Fragment(),
    SearchRecyclerAdapter.RecipeItemListener {

    private lateinit var recyclerView: RecyclerView
    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        //instantiate nav controller reference using its id from the xml of the main activity layout
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)
//        get shared instance of view model
        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        // Inflate the layout for this fragment
        val root = inflater.inflate(R.layout.fragment_search_results, container, false)

        //find the recyclerview
        recyclerView = root.findViewById(R.id.recyclerView)

        //subscribe to data changes in the repository class via the ViewModel
        sharedSearchViewModel.recipeData.observe(viewLifecycleOwner, Observer {
            //instantiate adapter
            val adapter =
                SearchRecyclerAdapter(
                    requireContext(),
                    it,
                    this
                )
            //set the adapter to the recyclerview
            recyclerView.adapter = adapter
        })

        return root
    }

    override fun onRecipeItemClick(recipe: Recipe) {
        Log.i(LOG_TAG, recipe.toString())
        sharedSearchViewModel.selectedRecipe.value = recipe
        navController.navigate(R.id.action_searchResultsFragment_to_recipeDetailFragment)
    }

}
