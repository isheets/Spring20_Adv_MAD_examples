package com.isaac.recipes.utils

import android.app.Application
import android.content.Context
import android.net.ConnectivityManager

class NetworkHelper {

    companion object {
        //activeNetworkInfo has been deprecate but we can't use the new alternative because our min API is too low
        @Suppress("DEPRECATION") //suppress the deprecation warnings
        fun networkConnected(app: Application): Boolean {
            val connectivityManager =
                app.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val networkInfo = connectivityManager.activeNetworkInfo
            return networkInfo?.isConnectedOrConnecting ?: false
        }
    }
}