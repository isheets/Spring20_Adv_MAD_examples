package com.isaac.recipes.data

data class Recipe (
    val id: Int,
    val title: String,
    val readyInMinutes: Int,
    val servings: Int,
    val image: String,
    val imageUrls: Set<String>
)

data class RecipeDetails (
    val title: String,
    val summary: String,
    val image: String,
    val readyInMinutes: Int,
    val servings: Int,
    val instructions: String,
    val extendedIngredients: Set<Ingredient>
)

data class Ingredient(
    val originalString: String,
    val name: String,
    val amount: Double,
    val unit: String
)