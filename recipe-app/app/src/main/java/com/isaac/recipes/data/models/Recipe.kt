package com.isaac.recipes.data.models

import com.isaac.recipes.data.database.favorite.Favorite
import com.squareup.moshi.JsonClass
import java.util.*

@JsonClass(generateAdapter = true)
data class SearchResponse (
    val results: Set<Recipe>,
    val number: Int,
    val totalResults: Int
)

@JsonClass(generateAdapter = true)
data class Recipe (
    val id: Int,
    val title: String,
    val readyInMinutes: Int,
    val servings: Int,
    val image: String
) {
    companion object {
        fun fromRoomFavorite(fav: Favorite): Recipe {
            return Recipe(fav.recipe_id, fav.title, fav.ready_in_minutes, fav.servings, fav.image)
        }
    }
}

@JsonClass(generateAdapter = true)
data class RecipeDetails (
    val id: Int,
    val title: String,
    val summary: String,
    val image: String,
    val readyInMinutes: Int,
    val servings: Int,
    val analyzedInstructions: List<Steps>,
    val extendedIngredients: Set<Ingredient>
) {
    //methods for converting to and from room entities
    fun getRoomFavorite(): Favorite {
        return Favorite(id, title, summary, image, readyInMinutes, servings, Date())
    }

    fun getRoomIngredients(): List<com.isaac.recipes.data.database.ingredient.Ingredient> {
        var roomIngredientList = mutableListOf<com.isaac.recipes.data.database.ingredient.Ingredient>()


        for(ingredient in extendedIngredients) {
            roomIngredientList.add(com.isaac.recipes.data.database.ingredient.Ingredient(recipe_id = id,
                name=ingredient.name,
                unit = ingredient.unit,
                amount = ingredient.amount))
        }

        return roomIngredientList
    }

    fun getRoomInstructions(): List<com.isaac.recipes.data.database.instruction.Instruction> {
        var roomInstructionList = mutableListOf<com.isaac.recipes.data.database.instruction.Instruction>()

        for(instruction in analyzedInstructions[0].steps) {
            roomInstructionList.add(com.isaac.recipes.data.database.instruction.Instruction(recipe_id = id,
                number = instruction.number,
                step = instruction.step))
        }

        return roomInstructionList
    }

    companion object {
        fun fromRoomTypes(fav: Favorite,
                          roomInstructions: List<com.isaac.recipes.data.database.instruction.Instruction>,
                          roomIngredients: List<com.isaac.recipes.data.database.ingredient.Ingredient>): RecipeDetails {
            //create ingredient set
            var ingredientSet = mutableSetOf<Ingredient>()

            for(roomIngredient in roomIngredients) {
                ingredientSet.add(Ingredient("${roomIngredient.amount} ${roomIngredient.unit} ${roomIngredient.name}",
                    roomIngredient.name,
                    roomIngredient.amount,
                    roomIngredient.unit))
            }

            //create instruction list
            var instructionList = mutableListOf<Instruction>()

            for(roomInstruction in roomInstructions) {
                instructionList.add(
                    Instruction(
                    roomInstruction.number,
                    roomInstruction.step
                ))
            }

            //construct and return the converted object
            return RecipeDetails(fav.recipe_id,
                fav.title,
                fav.summary,
                fav.image,
                fav.ready_in_minutes,
                fav.servings,
                listOf(Steps(instructionList)),
                ingredientSet)

        }
    }
}

@JsonClass(generateAdapter = true)
data class Ingredient(
    val originalString: String,
    val name: String,
    val amount: Double,
    val unit: String
)

@JsonClass(generateAdapter = true)
data class Steps(
    val steps: List<Instruction>
)

@JsonClass(generateAdapter = true)
data class Instruction(
    val number: Int,
    val step: String
)