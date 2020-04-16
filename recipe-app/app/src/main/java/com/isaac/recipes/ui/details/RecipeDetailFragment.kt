package com.isaac.recipes.ui.details

import android.annotation.SuppressLint
import android.content.DialogInterface
import android.os.Bundle
import android.util.Log
import android.view.*
import android.view.animation.AlphaAnimation
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

    private var resumed = false

    private val updateViewWithDetails = Observer<RecipeDetails> {
        //set the current recipe
        currentRecipe = it

        //check to see if the user has already added a favorite
        favoritesVM.isRecipeFavorited(it.id)

        //set the title in the action bar
        (activity as AppCompatActivity?)?.supportActionBar?.title = it.title
        //set the title textview
        recipeTitleTextView.text = it.title

        //images can be fetched using the following pattern: https://spoonacular.com/recipeImages/{ID}-{SIZE}.{TYPE}
        //runs on background thread
        Glide.with(this)
            .load("${IMAGE_BASE_URL}/${it.id}-556x370.jpg")
            .into(imageView)

        //get ingredient names
        val ingredientList = mutableListOf<String>()
        for(ingredient in it.extendedIngredients) {
            ingredientList.add(ingredient.originalString)
        }
        //add instantiate and use adapter for recyclerview
        val ingredientAdapter =
            DetailsRecyclerAdapter(
                requireContext(),
                ingredientList
            )
        ingredientListView.adapter = ingredientAdapter

        //setup recyclerview for instructions
        val instructionList = mutableListOf<String>()
        for(instruction in it.analyzedInstructions[0].steps) {
            instructionList.add("${instruction.number}. ${instruction.step}")
        }
        val instructionAdapter = DetailsRecyclerAdapter(requireContext(), instructionList)
        instructionsRecyclerView.adapter = instructionAdapter

        toggleLoading(false)
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

        toggleLoading(true)

        var constraints = ConstraintSet()
        constraints.clone(constraintLayout)
        constraints.connect(loadingBar.id, ConstraintSet.RIGHT, constraintLayout.id, ConstraintSet.RIGHT, 8)
        constraints.connect(loadingBar.id, ConstraintSet.LEFT, constraintLayout.id, ConstraintSet.LEFT, 8)
        constraints.connect(loadingBar.id, ConstraintSet.TOP, constraintLayout.id, ConstraintSet.TOP, 32)

        constraints.applyTo(constraintLayout)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        favoritesVM = ViewModelProvider(requireActivity()).get(SharedFavoritesViewModel::class.java)

        //load the details into the view when they are updated either from SearchResults or from Favorites
        sharedSearchViewModel.recipeDetails.observe(viewLifecycleOwner, updateViewWithDetails)
        favoritesVM.favDetails.observe(viewLifecycleOwner, updateViewWithDetails)

        return root
    }

    override fun onResume() {
        //hide content widgets and show progress bar
        resumed = true
        toggleLoading(true)
        super.onResume()
    }

    private fun toggleLoading(loading: Boolean) {
        Log.i(LOG_TAG, "toggleLoading $loading $resumed")
        if(loading) {
            Log.i(LOG_TAG, "hiding content")
            ingredientListView.alpha = 0.0f
            recipeTitleTextView.alpha = 0.0f
            instructionsRecyclerView.alpha = 0.0f
            imageView.alpha = 0.0f
            instructionTitleTextView.alpha = 0.0f
            ingredientTitleTextView.alpha = 0.0f
            loadingBar.visibility = View.VISIBLE

        } else if(!loading && resumed){
            Log.i(LOG_TAG, "fading content in")
            ingredientListView.animate().alpha(1.0f).duration = 200
            recipeTitleTextView.animate().alpha(1.0f).duration = 200
            instructionsRecyclerView.animate().alpha(1.0f).duration = 200
            imageView.animate().alpha(1.0f).duration = 200
            instructionTitleTextView.animate().alpha(1.0f).duration = 200
            ingredientTitleTextView.animate().alpha(1.0f).duration = 200
            loadingBar.visibility = View.GONE

            resumed = false
        }
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
