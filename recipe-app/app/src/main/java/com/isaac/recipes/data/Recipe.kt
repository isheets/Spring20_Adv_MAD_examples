package com.isaac.recipes.data

data class Recipe (
    val id: Int,
    val title: String,
    val readyInMinutes: Int,
    val servings: Int,
    val image: String,
    val imageUrls: Set<String>
)