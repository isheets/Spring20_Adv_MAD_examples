package com.isaac.recipes.data.database.instruction

import androidx.room.*
import com.isaac.recipes.data.database.ingredient.Ingredient

@Dao
interface InstructionDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertInstruction(instruction: Instruction)

    @Query("SELECT * FROM instructions_table WHERE recipe_id = :id")
    fun getInstructionsForRecipe(id: Int): List<Instruction>

    @Query("DELETE FROM instructions_table WHERE recipe_id = :id")
    fun deleteInstructions(id: Int)
}