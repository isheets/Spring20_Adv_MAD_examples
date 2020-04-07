package com.isaac.recipes

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentManager
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.google.android.material.bottomnavigation.BottomNavigationView


class MainActivity : AppCompatActivity() {

    private lateinit var navController: NavController
    private lateinit var navView: BottomNavigationView

    //show/hide bottom nav and up nav arrow based on where we are navigating to
    private val navControllerListener = NavController.OnDestinationChangedListener { controller, destination, arguments ->
        if(destination.id == R.id.navigation_favorites || destination.id == R.id.navigation_search) {
            //show bottom nav and hide up arrow
            supportActionBar?.setDisplayHomeAsUpEnabled(false)
            navView.visibility = android.view.View.VISIBLE
        } else {
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            navView.visibility = android.view.View.GONE
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        navView = findViewById(R.id.nav_view)

        navController = findNavController(R.id.nav_host_fragment)
        navController.addOnDestinationChangedListener(navControllerListener)
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        val appBarConfiguration = AppBarConfiguration(setOf(
                R.id.navigation_search, R.id.navigation_favorites))
        setupActionBarWithNavController(navController, appBarConfiguration)
        navView.setupWithNavController(navController)
    }

    override fun onSupportNavigateUp(): Boolean {
        navController.navigateUp();
        return true;
    }
}
