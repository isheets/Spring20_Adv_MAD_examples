package com.isaac.recipes.ui.search

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.isaac.recipes.data.RecipeRepository
import com.isaac.recipes.utils.FileHelper

class SearchViewModel(app: Application) : AndroidViewModel(app) {
    //instantiate repository class
    private val recipeRepo = RecipeRepository(app)

    //get reference to LiveData object with a value of type List<Recipe>
    val recipeData = recipeRepo.recipeData

    private val _text = MutableLiveData<String>().apply {
        value = "This is the Search Fragment"
    }
    val text: LiveData<String> = _text
}