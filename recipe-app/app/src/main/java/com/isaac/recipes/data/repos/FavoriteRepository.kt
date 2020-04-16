package com.isaac.recipes.data.repos

import android.app.Application
import android.database.Observable
import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.isaac.recipes.data.database.AppDatabase
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.database.ingredient.Ingredient
import com.isaac.recipes.data.database.instruction.Instruction
import com.isaac.recipes.data.database.relation.FavoriteWithDetails
import com.isaac.recipes.data.models.Recipe
import com.isaac.recipes.data.models.RecipeDetails
import java.util.*
import androidx.lifecycle.Observer
import com.isaac.recipes.LOG_TAG
import kotlinx.coroutines.*

class FavoriteRepository(val app: Application) {
    private val db = AppDatabase.getDatabase(app)

    //dao references
    private val favoriteWithDetailsDAO = db.favoriteWithDetailsDAO()
    private val favoriteDAO = db.favoriteDAO()
    private val ingredientDAO = db.ingredientDAO()
    private val instructionDAO = db.instructionDAO()

    val favoriteRoomList: LiveData<List<Favorite>> = favoriteDAO.getAllFavorites()


    //transforms RecipeWithDetails to Favorite, List<Instructions>, List<Ingredients> and adds to Room using DAOs
    fun addFavorite(recipe: RecipeDetails) {
        CoroutineScope(Dispatchers.IO).launch {
            //insert the favorite
            favoriteDAO.insertFavorite(recipe.getRoomFavorite())
            //insert each instruction
            for(instruction in recipe.getRoomInstructions()) {
                instructionDAO.insertInstruction(instruction)
            }
            //insert each ingredient
            for(ingredient in recipe.getRoomIngredients()) {
                ingredientDAO.insertIngredient(ingredient)
            }
        }
    }

    val favoriteDetails: MutableLiveData<RecipeDetails> = MutableLiveData()

    fun getDetailsForRecipe(recipe: Recipe) {
        CoroutineScope((Dispatchers.IO)).launch {
            val fav = favoriteDAO.getFavorite(recipe.id)
            val instructions = instructionDAO.getInstructionsForRecipe(fav.recipe_id)
            val ingredients = ingredientDAO.getIngredientsForRecipe(fav.recipe_id)

            favoriteDetails.postValue(RecipeDetails.fromRoomTypes(fav, instructions, ingredients))
        }
    }

    fun removeRecipeFromFavorites(id: Int) {
        CoroutineScope(Dispatchers.IO).async {
            ingredientDAO.deleteIngredients(id)
            instructionDAO.deleteInstructions(id)
            favoriteDAO.removeFavorite(id)
        }
    }

    val recipeIsFavorite = MutableLiveData<Boolean>()

    fun isRecipeFavorited(id: Int) {
        CoroutineScope(Dispatchers.IO).launch {
            val favorite = favoriteDAO.getFavorite(id)
            Log.i(LOG_TAG, "Looking for favorite, found ${favorite}")
            recipeIsFavorite.postValue( favorite != null)
        }
    }
}