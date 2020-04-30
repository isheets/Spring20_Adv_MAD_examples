package com.isaac.recipes.utils

import android.content.Context

class FileHelper {
    //functions like a static method
    companion object {
        fun readTextFromAssets(context: Context, filename: String): String {
            //the .use() methods to make sure that all of my streams are closed appropriately
            return context.assets.open(filename).use { inputStream ->
                inputStream.bufferedReader().use {
                    it.readText()
                }
            }

        }
    }
}