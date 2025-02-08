package com.example.dog_play_date

import android.os.Bundle
import android.os.StrictMode
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Optionnel : Désactivation de StrictMode pour éviter des violations en mode debug
         StrictMode.setThreadPolicy(StrictMode.ThreadPolicy.Builder().permitAll().build())
    }
}
