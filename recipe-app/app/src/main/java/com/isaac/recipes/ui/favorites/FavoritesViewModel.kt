package com.isaac.recipes.ui.favorites

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.isaac.recipes.data.FavoriteRepository

class FavoritesViewModel(app: Application) : AndroidViewModel(app) {

    private val favRepo = FavoriteRepository(app)

    val favoriteList = favRepo.allFavorites

    fun testDaos() {
        favRepo.getIngredientsForRecipe(1)
        favRepo.getInstructionsForRecipe(1)
    }

    private val _text = MutableLiveData<String>().apply {
        value = "This is the Favorites Fragment"
    }
    val text: LiveData<String> = _text
}