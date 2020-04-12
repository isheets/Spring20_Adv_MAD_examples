package com.isaac.recipes.data.database.instruction

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface InstructionDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertInstruction(instruction: Instruction)

    @Query("SELECT * FROM instructions_table WHERE recipe_id = :id")
    fun getInstructionsForRecipe(id: Int): List<Instruction>
}