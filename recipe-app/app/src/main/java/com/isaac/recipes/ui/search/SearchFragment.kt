package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.R

class SearchFragment : Fragment() {

    private lateinit var searchViewModel: SearchViewModel
    private lateinit var recyclerView: RecyclerView

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        //instance of ViewModel
        searchViewModel = ViewModelProvider(this).get(SearchViewModel::class.java)

        val root = inflater.inflate(R.layout.fragment_search, container, false)
        recyclerView = root.findViewById(R.id.recyclerView)

        //subscribe to data changes in the repository class via the ViewModel
        searchViewModel.recipeData.observe(viewLifecycleOwner, Observer {
            //instantiate adapter
            val adapter = SearchRecyclerAdapter(requireContext(), it)
            //set the adapter to the recyclerview
            recyclerView.adapter = adapter
        })

        return root
    }
}
