package com.isaac.recipes.data

import android.app.Application
import android.util.Log
import androidx.annotation.WorkerThread
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.isaac.recipes.BASE_URL
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.utils.FileHelper
import com.isaac.recipes.utils.NetworkHelper
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class RecipeRepository(val app: Application) {

    //parameterized type property for Moshi
    private val listType = Types.newParameterizedType(List::class.java, Recipe::class.java)

    //LiveData object consisting of our recipe data
    //we will publish from this class and subscribe from our fragment
    val recipeData = MutableLiveData<List<Recipe>>()

    //fetch the data when the class is instantiated
    init {
        getRecipeList()
        CoroutineScope(Dispatchers.IO).launch {
            searchAPI("pasta")
        }
    }


    //get the raw text from our json file and update the LiveData object with the parsed data
    private fun getRecipeList() {
        val dataText = FileHelper.readTextFromAssets(app, "recipe-data.json")

        val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
        val adapter: JsonAdapter<List<Recipe>> = moshi.adapter(listType)

        //update our LiveData object with the results of our parsing
        recipeData.value = adapter.fromJson(dataText) ?: emptyList()
    }

//    This portion of the class is dedicated to fetching detail for a specific recipe and updating the LiveData object
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

    @WorkerThread
    suspend fun searchAPI(searchTerm: String) {
        if(NetworkHelper.networkConnected(app)) {
            val retrofit = Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(MoshiConverterFactory.create())
                .build()

            val service = retrofit.create(SpoonacularService::class.java)

            val response = service.searchRecipes(searchTerm).execute()
            val results = response.body()

            Log.i(LOG_TAG, results.toString())
        }
    }


}