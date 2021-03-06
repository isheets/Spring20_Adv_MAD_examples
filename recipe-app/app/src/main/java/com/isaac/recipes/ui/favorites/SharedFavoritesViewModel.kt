package com.isaac.recipes.ui.favorites

import android.app.Application
import androidx.lifecycle.*
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.models.Recipe
import com.isaac.recipes.data.models.RecipeDetails
import com.isaac.recipes.data.repos.FavoriteRepository

class SharedFavoritesViewModel(app: Application) : AndroidViewModel(app) {
    private val favRepo = FavoriteRepository(app)

    val favDetails: MutableLiveData<RecipeDetails> = favRepo.favoriteDetails

    val favoriteRecipeList: MutableLiveData<List<Recipe>> = favRepo.favoriteList

    var recipeToShow = 0

    //get selected favorites details and update live data
    fun favSelected(recipe: Recipe) {
        favRepo.getDetailsForRecipe(recipe)
    }

    //pass new favorite to repo class for transform and insertion
    fun addFavorite(recipe: RecipeDetails) {
        favRepo.addFavorite(recipe)
    }

    fun removeRecipeFromFavorites(id: Int) = favRepo.removeRecipeFromFavorites(id)

    val isFavorite = favRepo.recipeIsFavorite

    fun isRecipeFavorited(id: Int) {
        favRepo.isRecipeFavorited(id)
    }
}