package com.isaac.recipes.data.database.relation

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.PrimaryKey
import androidx.room.Relation
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.database.ingredient.Ingredient
import com.isaac.recipes.data.database.instruction.Instruction

data class FavoriteWithDetails (
    @Embedded @PrimaryKey val favorite: Favorite,

    @Relation(
        parentColumn = "recipe_id",
        entityColumn = "recipe_id",
        entity = Instruction::class
    ) val instructions: List<Instruction>,

    @Relation(
        parentColumn = "recipe_id",
        entityColumn = "recipe_id",
        entity = Ingredient::class
    ) val ingredient: List<Ingredient>
)