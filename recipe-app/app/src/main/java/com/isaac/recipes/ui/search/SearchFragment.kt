package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R
import com.isaac.recipes.data.Recipe

class SearchFragment : Fragment() {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel

    private lateinit var navController: NavController

    private lateinit var searchButton: Button
    private lateinit var searchEditText: EditText

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {

        //instance of ViewModel
        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        //instantiate nav controller reference using its id from the xml of the main activity layout
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_search, container, false)

        searchButton = root.findViewById(R.id.searchButton)
        searchEditText = root.findViewById(R.id.searchInput)

        searchButton.setOnClickListener {
            searchRecipes()
        }

        return root
    }

    private fun searchRecipes() {
        val searchTerm = searchEditText.text.toString()
        if(searchTerm != null && searchTerm != "") {
            sharedSearchViewModel.searchUserInput.value = searchTerm

            navController.navigate(R.id.action_navigation_search_to_searchResultsFragment)
        }
    }
}
