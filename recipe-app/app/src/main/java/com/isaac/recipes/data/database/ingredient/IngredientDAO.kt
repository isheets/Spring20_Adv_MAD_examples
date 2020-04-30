package com.isaac.recipes.data.database.ingredient

import androidx.room.*

@Dao
interface IngredientDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertIngredient(ingredient: Ingredient)

    @Query("SELECT * FROM ingredients_table WHERE recipe_id = :id")
    fun getIngredientsForRecipe(id: Int): List<Ingredient>

    @Query("DELETE FROM ingredients_table WHERE recipe_id = :id")
    fun deleteIngredients(id: Int)
}