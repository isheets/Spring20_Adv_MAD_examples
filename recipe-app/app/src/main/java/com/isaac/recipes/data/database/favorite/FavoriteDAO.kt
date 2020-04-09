package com.isaac.recipes.data.database.favorite

import androidx.lifecycle.LiveData
import androidx.room.*

@Dao
interface FavoriteDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertFavorite(favorite: Favorite)

    @Query("SELECT * FROM favorites_table")
    fun getAllFavorites(): LiveData<List<Favorite>>
}