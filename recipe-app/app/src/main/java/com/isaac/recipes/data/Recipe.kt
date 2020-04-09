package com.isaac.recipes.data

import com.squareup.moshi.JsonClass

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
    val servings: Int,
    val readyInMinutes: Int,
    val image: String
)

@JsonClass(generateAdapter = true)
data class RecipeDetails (
    val title: String,
    val summary: String,
    val image: String,
    val readyInMinutes: Int,
    val servings: Int,
    val analyzedInstructions: List<Steps>,
    val extendedIngredients: Set<Ingredient>
)

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