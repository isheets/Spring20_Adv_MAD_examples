package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R
import com.isaac.recipes.data.Recipe

class SearchFragment : Fragment(), SearchRecyclerAdapter.RecipeItemListener {

    private lateinit var searchViewModel: SearchViewModel
    private lateinit var recyclerView: RecyclerView
    private lateinit var navController: NavController

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {

        (requireActivity() as AppCompatActivity).run{
            supportActionBar?.setDisplayHomeAsUpEnabled(false)
        }

        //instance of ViewModel
        searchViewModel = ViewModelProvider(this).get(SearchViewModel::class.java)

        //instantiate nav controller reference using its id from the xml of the main activity layout
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_search, container, false)
        recyclerView = root.findViewById(R.id.recyclerView)

        //subscribe to data changes in the repository class via the ViewModel
        searchViewModel.recipeData.observe(viewLifecycleOwner, Observer {
            //instantiate adapter
            val adapter = SearchRecyclerAdapter(requireContext(), it, this)
            //set the adapter to the recyclerview
            recyclerView.adapter = adapter
        })

        return root
    }

    override fun onRecipeItemClick(recipe: Recipe) {
        Log.i("recipeLogging", recipe.toString())
        try {
            navController.navigate(R.id.action_navigation_search_to_recipeDetailFragment)
        } catch(e: Error){
            Log.i("recipeLogger", "could not navigate to item")
        }
    }
}
