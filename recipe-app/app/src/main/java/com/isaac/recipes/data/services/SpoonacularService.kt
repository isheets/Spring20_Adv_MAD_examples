package com.isaac.recipes.data.services

import com.isaac.recipes.API_KEY
import com.isaac.recipes.data.models.RecipeDetails
import com.isaac.recipes.data.models.SearchResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface SpoonacularService {
    @GET("recipes/search?apiKey=${API_KEY}")
    fun searchRecipes(@Query("query") searchTerm: String): Call<SearchResponse>

    @GET("recipes/{id}/information?apiKey=${API_KEY}")
    fun recipeDetails(@Path("id") id: Int): Call<RecipeDetails>
}