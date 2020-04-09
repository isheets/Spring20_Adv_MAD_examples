package com.isaac.recipes.data.database.relation

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Query
import androidx.room.Transaction

@Dao
interface FavoriteWithDetailsDAO {
    @Transaction
    @Query("SELECT * FROM favorites_table")
    fun getAllFavoritesWithDetails(): LiveData<List<FavoriteWithDetails>>
}