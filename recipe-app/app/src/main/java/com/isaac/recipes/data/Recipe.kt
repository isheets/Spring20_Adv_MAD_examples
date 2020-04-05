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
    val readyInMinutes: Int,
    val servings: Int,
    val image: String,
    val imageUrls: Set<String>
)

@JsonClass(generateAdapter = true)
data class RecipeDetails (
    val title: String,
    val summary: String,
    val image: String,
    val readyInMinutes: Int,
    val servings: Int,
    val instructions: String,
    val extendedIngredients: Set<Ingredient>
)

@JsonClass(generateAdapter = true)
data class Ingredient(
    val originalString: String,
    val name: String,
    val amount: Double,
    val unit: String
)