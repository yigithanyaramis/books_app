package com.yigithanyaramis.booksapp

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Intent'i işle
        handleDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Yeni Intent'i işle
        handleDeepLink(intent)
    }

    private fun handleDeepLink(intent: Intent) {
        // Bu metod sadece intent'in işlenmesini sağlar, MethodChannel kullanmadan
        if (intent.action == Intent.ACTION_VIEW && intent.data != null) {
            intent.data?.let { uri ->
                // Flutter'daki `AutoRoute` deep link'i işleyecektir.
            }
        }
    }
}
