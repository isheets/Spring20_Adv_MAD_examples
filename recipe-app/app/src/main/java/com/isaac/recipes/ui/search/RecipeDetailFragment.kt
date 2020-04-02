package com.isaac.recipes.ui.search

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentManager
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.isaac.recipes.R

/**
 * A simple [Fragment] subclass.
 */
class RecipeDetailFragment : Fragment() {

    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        //instantiate nav controller reference using its id from the xml of the main activity layout
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        return inflater.inflate(R.layout.fragment_recipe_detail, container, false)
    }

}
