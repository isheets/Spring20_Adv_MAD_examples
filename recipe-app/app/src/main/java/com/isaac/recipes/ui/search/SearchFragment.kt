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
import com.isaac.recipes.R

class SearchFragment : Fragment() {

    private lateinit var searchViewModel: SearchViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        //instance of ViewModel
        searchViewModel = ViewModelProvider(this).get(SearchViewModel::class.java)

        //subscribe to data changes in the repository class via the ViewModel
        searchViewModel.recipeData.observe(viewLifecycleOwner, Observer {
            for(recipe in it) {
                Log.i("recipeLogging", "${recipe.title} serves ${recipe.servings}")
            }

        })

        val root = inflater.inflate(R.layout.fragment_search, container, false)
        val textView: TextView = root.findViewById(R.id.text_search)
        searchViewModel.text.observe(viewLifecycleOwner, Observer {
            textView.text = it
        })
        return root
    }
}
