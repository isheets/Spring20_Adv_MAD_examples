package com.isaac.recipes.ui.search

import android.app.Application
import android.view.MenuItem
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.isaac.recipes.R
import com.isaac.recipes.data.models.Recipe
import com.isaac.recipes.data.repos.RecipeRepository

class SharedSearchViewModel(app: Application) : AndroidViewModel(app) {
    //instantiate repository class
    private val recipeRepo = RecipeRepository(app)

    //get reference to LiveData object with a value of type List<Recipe>
    val recipeData = recipeRepo.recipeData

    val recipeDetails = recipeRepo.recipeDetails

    val selectedRecipe = MutableLiveData<Recipe>()

    val searchUserInput = MutableLiveData<String>()

    var searchLoading = true

    //add the recipe repo observer
    init {
        selectedRecipe.observeForever(recipeRepo.recipeSelectedObserver)
        searchUserInput.observeForever(recipeRepo.searchTermEntered)
    }

    //called when the ViewModel is no longer used
    override fun onCleared() {
        //remove observers added with observe forever to prevent memory leak
        selectedRecipe.removeObserver(recipeRepo.recipeSelectedObserver)
        searchUserInput.removeObserver(recipeRepo.searchTermEntered)
        super.onCleared()
    }

}