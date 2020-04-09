package com.isaac.recipes.data

import android.app.Application
import android.util.Log
import androidx.lifecycle.LiveData
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.data.database.AppDatabase
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.database.ingredient.Ingredient
import com.isaac.recipes.data.database.instruction.Instruction
import com.isaac.recipes.data.database.relation.FavoriteWithDetails
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FavoriteRepository(val app:Application) {
    private val db = AppDatabase.getDatabase(app)

    //dao references
    private val favoriteWithDetails = db.favoriteWithDetailsDAO()
    private val favoriteDAO = db.favoriteDAO()
    private val ingredientDAO = db.ingredientDAO()
    private val instructionDao = db.instructionDAO()

    //get reference to the live data object
    val allFavorites: LiveData<List<FavoriteWithDetails>> = favoriteWithDetails.getAllFavoritesWithDetails()

    init {
        //put some dummy data into our data base
        CoroutineScope(Dispatchers.IO).launch {
            favoriteDAO.insertFavorite(Favorite(2, "pasta", "my dinner", "bad.png", 13, 2))
            instructionDao.insertInstruction(Instruction(recipe_id = 1, number = 1, step = "cry"))
            instructionDao.insertInstruction(Instruction(recipe_id = 2, number = 1, step = "boil water"))
            ingredientDAO.insertIngredient(Ingredient(recipe_id = 1, name = "pasta", amount = 1.0, unit = "whole"))
        }

    }

    fun getInstructionsForRecipe(recipeId: Int) {
        CoroutineScope(Dispatchers.IO).launch {
            Log.i(LOG_TAG, instructionDao.getInstructionsForRecipe(recipeId).toString())
        }
    }

    fun getIngredientsForRecipe(recipeId: Int) {
        CoroutineScope(Dispatchers.IO).launch {
            Log.i(LOG_TAG, ingredientDAO.getIngredientsForRecipe(recipeId).toString())
        }
    }



}