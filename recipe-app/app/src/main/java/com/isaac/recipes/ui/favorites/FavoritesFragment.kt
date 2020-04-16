package com.isaac.recipes.ui.favorites

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.R
import com.isaac.recipes.data.models.Recipe
import com.isaac.recipes.ui.adapters.RecipeRecyclerAdapter

class FavoritesFragment : Fragment(), RecipeRecyclerAdapter.RecipeItemListener {
    private lateinit var favVM: SharedFavoritesViewModel
    private lateinit var favRecyclerView: RecyclerView
    private lateinit var adapter: RecipeRecyclerAdapter
    private lateinit var navController: NavController

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        favVM =
                ViewModelProvider(requireActivity()).get(SharedFavoritesViewModel::class.java)

        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_favorites, container, false)
        favRecyclerView = root.findViewById(R.id.favoritesRecyclerView)

        adapter = RecipeRecyclerAdapter(requireContext(), emptyList<Recipe>(), this)
        favRecyclerView.adapter = adapter

        //add observer for new favorites in database
        favVM.favoriteRecipeList.observe(viewLifecycleOwner, Observer {
            adapter.recipeList = it
            adapter.notifyDataSetChanged()
        })

        return root
    }

    override fun onRecipeItemClick(recipe: Recipe) {
        favVM.favSelected(recipe)
        navController.navigate(R.id.action_navigation_favorites_to_recipeDetailFragment)
    }

    override fun onRecipeLongClick(recipe: Recipe) {

        val dialogBuilder = AlertDialog.Builder(requireContext())
        dialogBuilder.setMessage("Do you want to remove this recipe from your favorites?")
            .setCancelable(false)
            // positive button text and action
            .setPositiveButton("YES") { dialog, _ ->
                favVM.removeRecipeFromFavorites(recipe.id)
                Toast.makeText(requireContext(),"Recipe removed from Favorites!", Toast.LENGTH_SHORT).show()
                dialog.dismiss()
            }
            // negative button text and action
            .setNegativeButton("NO") {
                    dialog, _ -> dialog.cancel()
            }

        val alert = dialogBuilder.create()
        alert.setTitle("Remove Favorite")
        alert.show()
    }
}
