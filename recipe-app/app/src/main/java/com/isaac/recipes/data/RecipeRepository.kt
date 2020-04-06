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

    //properties for retrofit
    private var retrofit: Retrofit = Retrofit.Builder()
      .baseUrl(BASE_URL)
      .addConverterFactory(MoshiConverterFactory.create())
      .build()
    private var service: SpoonacularService

    //fetch the data when the class is instantiated
    init {
        //init the service instance
        service = retrofit.create(SpoonacularService::class.java)

        //async request for getting the recipes
        CoroutineScope(Dispatchers.IO).launch {
            getRecipeList("pasta")
        }

    }


    //search the API for recipes based on a searchTerm
    @WorkerThread
    private suspend fun getRecipeList(searchTerm: String) {
        if(NetworkHelper.networkConnected(app)) {
            val response = service.searchRecipes(searchTerm).execute()
            if(response.body() != null) {
                //successful request
                val responseBody = response.body()
                recipeData.postValue(responseBody?.results?.toList())
            } else {
                //there was an error with the request (or server)
                Log.e(LOG_TAG, "Could not search recipes. Error code: ${response.code()}")
            }
        }
    }

//    This portion of the class is dedicated to fetching detail for a specific recipe and updating the LiveData object
    val recipeSelectedObserver =  Observer<Recipe> {
        CoroutineScope(Dispatchers.IO).launch {
            getRecipeDetails(it)
        }
    }

    //LiveData for the recipe details
    val recipeDetails = MutableLiveData<RecipeDetails>()

    //get the raw text from our sample recipe details json
    @WorkerThread
    private suspend fun getRecipeDetails(forRecipe: Recipe) {
        if(NetworkHelper.networkConnected(app)) {
            val response = service.recipeDetails(forRecipe.id).execute()
            if(response.body() != null) {
                recipeDetails.postValue(response.body())
            } else {
                Log.e(LOG_TAG, "Could not find details for ${forRecipe.title}. Error code ${response.code()}")
            }
        }
    }

}