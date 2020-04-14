package com.isaac.recipes.data.database.favorite

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface FavoriteDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertFavorite(favorite: Favorite)

    @Query("SELECT * FROM favorites_table")
    fun getAllFavorites(): LiveData<List<Favorite>>

    @Query("SELECT * FROM favorites_table WHERE recipe_id = :id")
    fun getFavorite(id: Int): Favorite
}