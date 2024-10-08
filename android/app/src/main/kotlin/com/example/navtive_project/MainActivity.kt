package com.example.navtive_project;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.navtive_project/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getMessage") {
                val message = getNativeMessage()
                result.success(message)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getNativeMessage(): String {
        return "Hello from Android Native Code!"
    }
}
