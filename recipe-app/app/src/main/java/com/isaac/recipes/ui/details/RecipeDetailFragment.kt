package com.isaac.recipes.ui.details

import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
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

    //keep track of what recipe we are showing
    private lateinit var currentRecipe: RecipeDetails

    private val updateViewWithDetails = Observer<RecipeDetails> {
        //set the current recipe
        currentRecipe = it

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
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        //enable options meu
        setHasOptionsMenu(true)

        val root = inflater.inflate(R.layout.fragment_recipe_detail, container, false)

        //references to the necessary views
        ingredientListView = root.findViewById<RecyclerView>(R.id.ingredientsListView)
        recipeTitleTextView = root.findViewById<TextView>(R.id.recipeTitleTextView)
        instructionsRecyclerView = root.findViewById<RecyclerView>(R.id.instructionsRecyclerView)
        imageView = root.findViewById<ImageView>(R.id.recipeImageView)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        favoritesVM = ViewModelProvider(requireActivity()).get(SharedFavoritesViewModel::class.java)

        //load the details into the view when they are updated either from SearchResults or from Favorites
        sharedSearchViewModel.recipeDetails.observe(viewLifecycleOwner, updateViewWithDetails)
        favoritesVM.favDetails.observe(viewLifecycleOwner, updateViewWithDetails)

        return root
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.detail_menu, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        //toggle icon and title when pressing the star
        if(item.itemId == R.id.favoriteRecipe) {
            if (item.title == getString(R.string.save)) {
                item.icon = ResourcesCompat.getDrawable(
                    resources,
                    android.R.drawable.btn_star_big_on,
                    null
                )
                item.title = getString(R.string.remove)
                //pass new favorite to view model
                favoritesVM.addFavorite(currentRecipe)
            } else {
                item.icon = ResourcesCompat.getDrawable(
                    resources,
                    android.R.drawable.btn_star_big_off,
                    null
                )
                item.title = getString(R.string.save)
                //pass removed favorite to view model

            }
        } else {
            Log.i(LOG_TAG, item.itemId.toString())
        }

        return super.onOptionsItemSelected(item)
    }

}
