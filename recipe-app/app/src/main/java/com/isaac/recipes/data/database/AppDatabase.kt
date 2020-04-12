package com.isaac.recipes.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.isaac.recipes.data.database.favorite.Favorite
import com.isaac.recipes.data.database.favorite.FavoriteDAO
import com.isaac.recipes.data.database.ingredient.Ingredient
import com.isaac.recipes.data.database.ingredient.IngredientDAO
import com.isaac.recipes.data.database.instruction.Instruction
import com.isaac.recipes.data.database.instruction.InstructionDAO
import com.isaac.recipes.data.database.relation.FavoriteWithDetailsDAO

@Database(entities = [Ingredient::class, Instruction::class, Favorite::class],
    version = 2,
    exportSchema = false)
@TypeConverters(Converters::class)
abstract class AppDatabase: RoomDatabase() {
    abstract fun favoriteWithDetailsDAO(): FavoriteWithDetailsDAO
    abstract fun favoriteDAO(): FavoriteDAO
    abstract fun ingredientDAO(): IngredientDAO
    abstract fun instructionDAO(): InstructionDAO

    companion object {
        var INSTANCE: AppDatabase? = null

        //get reference to database OR create
        fun getDatabase(context: Context): AppDatabase {
            val tempInstance = INSTANCE
            //return instance if it exists
            if(tempInstance != null) return tempInstance

            //create instance if it does not exist
            synchronized(this) {
                val instance = Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, "recipe_database")
                    .fallbackToDestructiveMigration()
                    .build()

                INSTANCE = instance
                return instance
            }
        }
    }

}