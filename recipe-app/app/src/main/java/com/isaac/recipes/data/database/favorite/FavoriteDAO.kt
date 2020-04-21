package com.isaac.recipes.data.database.favorite

import androidx.lifecycle.LiveData
import androidx.room.*

@Dao
interface FavoriteDAO {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertFavorite(favorite: Favorite)

    @Query("SELECT * FROM favorites_table SORT ORDER BY date_added DESC")
    fun getAllFavorites(): LiveData<List<Favorite>>

    @Query("SELECT * FROM favorites_table WHERE recipe_id = :id")
    fun getFavorite(id: Int): Favorite

    @Query("DELETE FROM favorites_table WHERE recipe_id = :id")
    fun removeFavorite(id: Int)
}