package com.isaac.recipes.ui.details

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import androidx.core.content.res.ResourcesCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.isaac.recipes.IMAGE_BASE_URL
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.R
import com.isaac.recipes.data.models.DetailRecyclerViewItem
import com.isaac.recipes.data.models.RecipeDetails
import com.isaac.recipes.ui.favorites.SharedFavoritesViewModel
import com.isaac.recipes.ui.search.SharedSearchViewModel

/**
 * A simple [Fragment] subclass.
 */
class RecipeDetailFragment : Fragment() {

    //view models
    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var favoritesVM: SharedFavoritesViewModel

    //interface elements
    private lateinit var ingredientListView: RecyclerView
    private lateinit var recipeTitleTextView: TextView
    private lateinit var instructionsRecyclerView: RecyclerView
    private lateinit var imageView: ImageView
    private lateinit var ingredientTitleTextView: TextView
    private lateinit var instructionTitleTextView: TextView
    private lateinit var constraintLayout: ConstraintLayout

    //keep track of what recipe we are showing
    private lateinit var currentRecipe: RecipeDetails

    private lateinit var loadingBar: ProgressBar

    private fun updateView(newRecipe: RecipeDetails) {
        //set the current recipe
        currentRecipe = newRecipe

        //check to see if the user has already added a favorite
        favoritesVM.isRecipeFavorited(newRecipe.id)

        //set the title in the action bar
        (activity as AppCompatActivity?)?.supportActionBar?.title = newRecipe.title
        //set the title textview
        recipeTitleTextView.text = newRecipe.title

        //images can be fetched using the following pattern: https://spoonacular.com/recipeImages/{ID}-{SIZE}.{TYPE}
        var glideLoading = ResourcesCompat.getDrawable(
            resources,
            android.R.drawable.progress_indeterminate_horizontal,
            null
        )
        //runs on background thread
        Glide.with(this)
            .load("${IMAGE_BASE_URL}/${newRecipe.id}-312x231.jpg")
            .placeholder(glideLoading)
            .into(imageView)

        //get ingredient names
        val ingredientList = mutableListOf<DetailRecyclerViewItem>()
        for (ingredient in newRecipe.extendedIngredients) {
            ingredientList.add(
                DetailRecyclerViewItem(
                    "${"%.2f".format(ingredient.amount)} ${ingredient.unit}",
                    ingredient.name
                )
            )
        }
        //add instantiate and use adapter for recyclerview
        val ingredientAdapter =
            DetailsRecyclerAdapter(
                requireContext(),
                ingredientList
            )
        ingredientListView.adapter = ingredientAdapter

        //setup recyclerview for instructions
        val instructionList = mutableListOf<DetailRecyclerViewItem>()
        for (instruction in newRecipe.analyzedInstructions[0].steps) {
            instructionList.add(
                DetailRecyclerViewItem(
                    "${instruction.number}.",
                    instruction.step
                )
            )
        }
        val instructionAdapter = DetailsRecyclerAdapter(requireContext(), instructionList)
        instructionsRecyclerView.adapter = instructionAdapter

        toggleLoading(true)
    }

    private fun checkUpdateView(newRecipe: RecipeDetails, fav: Boolean) {
        if(fav) {
            //is a fav, check fav id
            if(newRecipe.id == favoritesVM.recipeToShow) {
                updateView(newRecipe)
                favoritesVM.recipeToShow = -1
            }
        } else {
            //not a fav
            if(newRecipe.id == sharedSearchViewModel.recipeToShow) {
                updateView(newRecipe)
                sharedSearchViewModel.recipeToShow = -1
            }
        }
    }

    fun toggleLoading(showContent: Boolean) {
        Log.i(LOG_TAG, "in toggleLoading()=$showContent")
        if(showContent) {
            ingredientListView.animate().alpha(1.0f).duration = 200
            recipeTitleTextView.animate().alpha(1.0f).duration = 200
            instructionsRecyclerView.animate().alpha(1.0f).duration = 200
            imageView.animate().alpha(1.0f).duration = 200
            instructionTitleTextView.animate().alpha(1.0f).duration = 200
            ingredientTitleTextView.animate().alpha(1.0f).duration = 200
            loadingBar.visibility = View.GONE
        } else {
            ingredientListView.alpha = 0.0f
            recipeTitleTextView.alpha = 0.0f
            instructionsRecyclerView.alpha = 0.0f
            imageView.alpha = 0.0f
            instructionTitleTextView.alpha = 0.0f
            ingredientTitleTextView.alpha = 0.0f
            loadingBar.visibility = View.VISIBLE
        }
    }

    @SuppressLint("ResourceType")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        //enable options meu
        setHasOptionsMenu(true)

        val root = inflater.inflate(R.layout.fragment_recipe_detail, container, false)

        //references to the necessary views
        ingredientListView = root.findViewById(R.id.ingredientsListView)
        recipeTitleTextView = root.findViewById(R.id.recipeTitleTextView)
        instructionsRecyclerView = root.findViewById(R.id.instructionsRecyclerView)
        imageView = root.findViewById(R.id.recipeImageView)
        instructionTitleTextView = root.findViewById(R.id.instructionsTitleTextView)
        ingredientTitleTextView = root.findViewById(R.id.ingredientsTextView)
        constraintLayout = root.findViewById(R.id.detailConstraintLayout)

        //loading bar with constraints
        loadingBar = ProgressBar(requireContext())
        loadingBar.id = 1
        constraintLayout.addView(loadingBar)

        var constraints = ConstraintSet()
        constraints.clone(constraintLayout)
        constraints.connect(loadingBar.id, ConstraintSet.RIGHT, constraintLayout.id, ConstraintSet.RIGHT, 8)
        constraints.connect(loadingBar.id, ConstraintSet.LEFT, constraintLayout.id, ConstraintSet.LEFT, 8)
        constraints.connect(loadingBar.id, ConstraintSet.TOP, constraintLayout.id, ConstraintSet.TOP, 32)

        constraints.applyTo(constraintLayout)

        toggleLoading(false)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        favoritesVM = ViewModelProvider(requireActivity()).get(SharedFavoritesViewModel::class.java)

        //load the details into the view when they are updated either from SearchResults or from Favorites
        sharedSearchViewModel.recipeDetails.observe(viewLifecycleOwner, Observer {
            if(it.id == sharedSearchViewModel.recipeToShow && it.id != favoritesVM.recipeToShow) {
                checkUpdateView(it, false)
            }
        })
        favoritesVM.favDetails.observe(viewLifecycleOwner, Observer {
            if(it.id == favoritesVM.recipeToShow && it.id != sharedSearchViewModel.recipeToShow) {
                checkUpdateView(it, true)
            }
        })

        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.detail_menu, menu)

        favoritesVM.isFavorite.observe(viewLifecycleOwner, Observer {
            val item = menu.findItem(R.id.favoriteRecipe)
            if(it) {
                setFavoriteMenuItemState(item, getString(R.string.remove))
            }
            else {
                setFavoriteMenuItemState(item, getString(R.string.save))
            }
        })

        super.onCreateOptionsMenu(menu, inflater)
    }

    private fun setFavoriteMenuItemState(menuItem: MenuItem, title: String) {
        menuItem.title = title
        if(title == getString(R.string.save)) {
            menuItem.icon = ResourcesCompat.getDrawable(
                resources,
                android.R.drawable.btn_star_big_off,
                null
            )
        } else if (title == getString(R.string.remove)) {
            menuItem.icon = ResourcesCompat.getDrawable(
                resources,
                android.R.drawable.btn_star_big_on,
                null
            )
        }
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        //toggle icon and title when pressing the star
        if(item.itemId == R.id.favoriteRecipe) {
            if (item.title == getString(R.string.save)) {
                setFavoriteMenuItemState(item, getString(R.string.remove))
                //pass new favorite to view model for persistence
                favoritesVM.addFavorite(currentRecipe)
                showFavToast("ADD")
            } else {
                confirmFavRemove(item)
            }
        }
        return super.onOptionsItemSelected(item)
    }

    private fun showFavToast(type: String) {
        if(type == "ADD") {
            Toast.makeText(requireContext(),"Recipe added to Favorites!", Toast.LENGTH_LONG).show()
        } else {
            Toast.makeText(requireContext(),"Recipe removed from Favorites!", Toast.LENGTH_SHORT).show()
        }
    }

    private fun confirmFavRemove(item: MenuItem) {
        val dialogBuilder = AlertDialog.Builder(requireContext())
        dialogBuilder.setMessage("Do you want to remove this recipe from your favorites?")
            .setCancelable(false)
            // positive button text and action
            .setPositiveButton("YES") { dialog, _ ->
                favoritesVM.removeRecipeFromFavorites(currentRecipe.id)
                setFavoriteMenuItemState(item, getString(R.string.save))
                showFavToast("REMOVE")
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
