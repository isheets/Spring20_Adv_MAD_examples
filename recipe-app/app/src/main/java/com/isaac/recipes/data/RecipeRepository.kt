package com.isaac.recipes.data

import android.app.Application
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.isaac.recipes.ui.search.SharedSearchViewModel
import com.isaac.recipes.utils.FileHelper
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory

class RecipeRepository(val app: Application, private val sharedSearchViewModel: SharedSearchViewModel) {

    //parameterized type property for Moshi
    private val listType = Types.newParameterizedType(List::class.java, Recipe::class.java)

    //LiveData object consisting of our recipe data
    //we will publish from this class and subscribe from our fragment
    val recipeData = MutableLiveData<List<Recipe>>()

    //fetch the data when the class is instantiated
    init {
        getRecipeList()
    }

    //get the raw text from our json file and update the LiveData object with the parsed data
    private fun getRecipeList() {
        val dataText = FileHelper.readTextFromAssets(app, "recipe-data.json")

        val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
        val adapter: JsonAdapter<List<Recipe>> = moshi.adapter(listType)

        //update our LiveData object with the results of our parsing
        recipeData.value = adapter.fromJson(dataText) ?: emptyList()
    }

    val recipeSelectedObserver =  Observer<Recipe> {
        getRecipeDetails(it)
    }

    //LiveData for the recipe details
    val recipeDetails = MutableLiveData<RecipeDetails>()

    //get the raw text from our sample recipe details json
    private fun getRecipeDetails(forRecipe: Recipe) {
        val detailsText = FileHelper.readTextFromAssets(app, "sample-recipe.json")

        val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
        val adapter: JsonAdapter<RecipeDetails> = moshi.adapter(RecipeDetails::class.java)

        //update our LiveData object with the results of our parsing
        recipeDetails.value = adapter.fromJson(detailsText)
    }


}