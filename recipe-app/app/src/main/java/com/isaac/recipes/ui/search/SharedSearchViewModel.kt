package com.isaac.recipes.ui.search

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.isaac.recipes.data.Recipe
import com.isaac.recipes.data.RecipeRepository
import com.isaac.recipes.utils.FileHelper

class SharedSearchViewModel(app: Application) : AndroidViewModel(app) {
    //instantiate repository class
    private val recipeRepo = RecipeRepository(app, this)

    //get reference to LiveData object with a value of type List<Recipe>
    val recipeData = recipeRepo.recipeData

    val recipeDetails = recipeRepo.recipeDetails

    val selectedRecipe = MutableLiveData<Recipe>()

    //add the recipe repo observer
    init {
        selectedRecipe.observeForever(recipeRepo.recipeSelectedObserver)
    }

    //called when the ViewModel is no longer used
    override fun onCleared() {
        //remove observers added with observe forever to prevent memory leak
        selectedRecipe.removeObserver(recipeRepo.recipeSelectedObserver)
        super.onCleared()
    }
}