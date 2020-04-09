package com.isaac.recipes.data.database.instruction

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey
import com.isaac.recipes.data.database.favorite.Favorite

@Entity (foreignKeys = [ForeignKey(
    entity = Favorite::class,
    parentColumns = ["recipe_id"],
    childColumns = ["recipe_id"]
)],
    tableName = "instructions_table"
)
data class Instruction(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val recipe_id: Int,
    val number: Int,
    val step: String
)
