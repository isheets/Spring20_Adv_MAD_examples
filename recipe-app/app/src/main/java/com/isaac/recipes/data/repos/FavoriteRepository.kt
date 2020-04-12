package com.isaac.recipes.data.repos

import android.app.Application
import androidx.lifecycle.LiveData
import com.isaac.recipes.data.database.AppDatabase
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.database.ingredient.Ingredient
import com.isaac.recipes.data.database.instruction.Instruction
import com.isaac.recipes.data.database.relation.FavoriteWithDetails
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.*

class FavoriteRepository(val app: Application) {
    private val db = AppDatabase.getDatabase(app)

    //dao references
    private val favoriteWithDetailsDAO = db.favoriteWithDetailsDAO()
    private val favoriteDAO = db.favoriteDAO()
    private val ingredientDAO = db.ingredientDAO()
    private val instructionDAO = db.instructionDAO()

    //get live data object of all favorites with details
    val allFavoritesWithDetails: LiveData<List<FavoriteWithDetails>> = favoriteWithDetailsDAO.getAllFavoritesWithDetails()

    init {
        //dummy data in db
        CoroutineScope(Dispatchers.IO).launch {
            favoriteDAO.insertFavorite(Favorite(1, "pasta", "my dinner", "pasta.png", 13, 1, Date()))
            instructionDAO.insertInstruction(Instruction(recipe_id = 1, number = 1, step = "boil water"))
            instructionDAO.insertInstruction(Instruction(recipe_id = 1, number = 2, step = "salt water"))
            ingredientDAO.insertIngredient(Ingredient(recipe_id = 1, name = "pasta", amount = 1.0, unit = "pound"))
        }
    }
}