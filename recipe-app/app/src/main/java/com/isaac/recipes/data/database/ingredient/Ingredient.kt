package com.isaac.recipes.data.database.ingredient

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey
import com.isaac.recipes.data.database.favorite.Favorite

@Entity(tableName = "ingredients_table",
    foreignKeys = [ForeignKey(
        entity = Favorite::class,
        parentColumns = ["recipe_id"],
        childColumns = ["recipe_id"]
    )]
)
data class Ingredient(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val recipe_id: Int,
    val name: String,
    val amount: Double,
    val unit: String
)