package com.isaac.recipes.data.database.ingredient

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface IngredientDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertIngredient(ingredient: Ingredient)

    @Query("SELECT * FROM ingredients_table WHERE recipe_id = :id")
    fun getIngredientsForRecipe(id: Int): List<Ingredient>
}