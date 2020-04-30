package com.isaac.recipes.data.database.favorite

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity(tableName = "favorites_table")
data class Favorite(
    @PrimaryKey val recipe_id: Int,
    val title: String,
    val summary: String,
    val image: String,
    val ready_in_minutes: Int,
    val servings: Int,
    val date_added: Date
)