package com.ccavenue.ccavenue_india_sdk_flutter

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.Serializable
import android.util.Log

class CcavenueIndiaSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugin_ccavenue")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        this.activity = null
    }

    companion object {
        var onSuccess: ((String) -> Unit)? = null
        var onError: ((String) -> Unit)? = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "payCCAvenue") {
            val currentActivity = activity
            if (currentActivity == null) {
                result.error("NO_ACTIVITY", "Activity is null", null)
                return
            }

            // Set static callbacks to return data to Flutter
            onSuccess = { response -> result.success(response) }
            onError = { error -> result.error("TRANSACTION_ERROR", error, null) }

            val intent = Intent(currentActivity, CCAvenueWrapperActivity::class.java)
            
            intent.putExtra("accessCode", call.argument<String>("accessCode") ?: "")
            intent.putExtra("encRequest", call.argument<String>("encRequest") ?: "")
          
            intent.putExtra("paymentEnvironment", call.argument<String>("paymentEnvironment") ?: "production")
            intent.putExtra("appColor", call.argument<String>("appColor") ?: "#1F46BD")
            intent.putExtra("fontColor", call.argument<String>("fontColor") ?: "#FFFFFF")
  
            currentActivity.startActivity(intent)

        } else { 
            result.notImplemented()
        }
    }
}