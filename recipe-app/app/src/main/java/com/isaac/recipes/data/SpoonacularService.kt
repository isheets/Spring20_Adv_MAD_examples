package com.isaac.recipes.data

import com.isaac.recipes.API_KEY
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface SpoonacularService {
    @GET("recipes/search?apiKey=${API_KEY}")
    fun searchRecipes(@Query("q") searchTerm: String): Call<SearchResponse>

    @GET("recipes/{id}/information?apiKey=${API_KEY}")
    fun recipeDetails(@Path("id") id: Int): Call<RecipeDetails>
}