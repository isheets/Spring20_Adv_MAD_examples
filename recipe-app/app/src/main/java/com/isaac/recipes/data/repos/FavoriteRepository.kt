package com.isaac.recipes.data.repos

import android.app.Application
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.QuerySnapshot
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.isaac.recipes.LOG_TAG
import com.isaac.recipes.data.models.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

class FavoriteRepository(val app: Application) {
    private val db = Firebase.firestore

    val favoriteList = MutableLiveData<List<Recipe>>()
    val favoriteDetails = MutableLiveData<RecipeDetails>()
    private val allData: MutableMap<Int, RecipeDetails> = mutableMapOf()

    val recipeIsFavorite = MutableLiveData<Boolean>()

    init {
        db.collection("favorites")
            .addSnapshotListener { snapshot, e ->
                if(e != null) {
                    Log.e(LOG_TAG, "Listen failed.", e)
                    return@addSnapshotListener
                }
                if (snapshot != null) {
                    parseAllData(snapshot)
                } else {
                    Log.d(LOG_TAG, "Current data: null")
                }

            }

    }

    private fun parseAllData(result: QuerySnapshot) {
        val allFavorites = mutableListOf<Recipe>()
        for(doc in result) {
            //get the data from the document
            val id: Int = (doc.get("id") as Long).toInt()
            val title: String = doc.getString("title")!!
            val summary: String = doc.getString("summary")!!
            val image: String = doc.getString("image")!!
            val readyInMinutes: Int = (doc.get("readyInMinutes") as String).toInt()
            val servings: Int = doc.getString("servings")!!.toInt()
            val genericInstructions: ArrayList<*> = doc.get("instructions") as ArrayList<*>
            val genericIngredients : ArrayList<*> = doc.get("ingredients") as ArrayList<*>

            //add to all favorites array
            allFavorites.add(Recipe(
                id,
                title,
                readyInMinutes,
                servings,
                image
            ))

            allData[id] = RecipeDetails(
                id,
                title,
                summary,
                image,
                readyInMinutes,
                servings,
                listOf(Steps(getRecipeInstructions(genericInstructions))),
                getRecipeIngredients(genericIngredients)
            )
        }

        Log.i(LOG_TAG, "allData: $allData")

        favoriteList.value = allFavorites
    }

    private fun getRecipeInstructions(dbArray: ArrayList<*>): List<Instruction> {
        val instructions = mutableListOf<Instruction>()
        for(obj in dbArray) {
            val map = obj as HashMap<*, *>
            instructions.add(
                Instruction(
                    (map["number"] as String).toInt(),
                    map["step"] as String
                ))
        }

        return instructions
    }

    private fun getRecipeIngredients(dbArray: ArrayList<*>): Set<Ingredient> {
        val ingredients = mutableSetOf<Ingredient>()
        for(obj in dbArray) {
            val map = obj as HashMap<*, *>
            ingredients.add(Ingredient(map["originalString"] as String,
                map["name"] as String,
                (map["amount"] as String).toDouble(),
                map["unit"] as String
            ))
        }
        return ingredients
    }

    fun isRecipeFavorited(id: Int) {
        recipeIsFavorite.value = allData.containsKey(id)
    }



    fun getDetailsForRecipe(recipe: Recipe) {
        favoriteDetails.value = allData[recipe.id]
    }

    fun removeRecipeFromFavorites(id: Int) {}

    fun addFavorite(recipe: RecipeDetails) {
        val recipeMap = recipeDetailsToHashMap(recipe)

        db.collection("favorites").add(recipeMap)
            .addOnSuccessListener {
                Log.i(LOG_TAG, "Added favorite success!")
            }
            .addOnFailureListener { exception ->
                Log.w(LOG_TAG, "Error adding document.", exception)
            }
    }

    private fun recipeDetailsToHashMap(recipe: RecipeDetails): HashMap<String, *> {
        val map = hashMapOf(
            "id" to recipe.id,
            "title" to recipe.title,
            "summary" to recipe.summary,
            "image" to recipe.image,
            "readyInMinutes" to recipe.readyInMinutes.toString(),
            "servings" to recipe.servings.toString(),
            "ingredients" to ingredientsToArrayOfMaps(recipe.extendedIngredients),
            "instructions" to instructionsToArrayOfMaps(recipe.analyzedInstructions[0].steps)
        )
        return map
    }

    private fun ingredientsToArrayOfMaps(ingredients: Set<Ingredient>): ArrayList<HashMap<String, *>> {
        val ingredientArrayList = ArrayList<HashMap<String, *>>()

        for(ingredient in ingredients) {
            ingredientArrayList.add(hashMapOf(
                "originalString" to ingredient.originalString,
                "name" to ingredient.name,
                "amount" to ingredient.amount.toString(),
                "unit" to ingredient.unit
            ))
        }
        return ingredientArrayList
    }

    private fun instructionsToArrayOfMaps(instructions: List<Instruction>): ArrayList<HashMap<String, *>> {
        val instructionArrayList = ArrayList<HashMap<String, *>>()

        for(instruction in instructions) {
            instructionArrayList.add(hashMapOf(
                "number" to instruction.number.toString(),
                "step" to instruction.step
            ))
        }

        return instructionArrayList
    }

}