package com.isaac.recipes

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.ImageView
import android.widget.Toast
import android.widget.ViewSwitcher
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentManager
import androidx.navigation.NavController
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.IdpResponse
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.firebase.auth.FirebaseAuth


class MainActivity : AppCompatActivity() {

    private lateinit var navController: NavController
    private lateinit var navView: BottomNavigationView
    private lateinit var bgImage: ImageView

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

        if(destination.id == R.id.navigation_search) {
            bgImage.animate().alpha(1f).duration = 200
        } else {
            bgImage.animate().alpha(0f).duration = 200
        }
    }
    // Choose authentication providers
    private val providers = arrayListOf(AuthUI.IdpConfig.GoogleBuilder().build())

    private lateinit var viewSwitcher: ViewSwitcher
    private lateinit var signInButton: Button

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == 1) {
            val response = IdpResponse.fromResultIntent(data)

            if (resultCode == Activity.RESULT_OK) {
                val user = FirebaseAuth.getInstance().currentUser
                Toast.makeText(this,"Welcome, ${user?.displayName}!", Toast.LENGTH_LONG).show()
                viewSwitcher.showNext()
            } else {
                if(response != null) {
                    Log.e(LOG_TAG, response.error?.localizedMessage!!)
                    Toast.makeText(this,"Could not complete sign in, try again!", Toast.LENGTH_LONG).show()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        viewSwitcher = findViewById(R.id.signInSwitcher)
        signInButton = findViewById<Button>(R.id.signInButton)
        signInButton.setOnClickListener {
            // Create and launch sign-in intent
            startActivityForResult(
                AuthUI.getInstance()
                    .createSignInIntentBuilder()
                    .setAvailableProviders(providers)
                    .build(),
                1
            )
        }

        navView = findViewById(R.id.nav_view)
        bgImage = findViewById(R.id.mainBgImage)

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
