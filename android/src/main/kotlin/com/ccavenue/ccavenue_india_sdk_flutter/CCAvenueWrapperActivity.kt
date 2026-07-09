package com.ccavenue.ccavenue_india_sdk_flutter

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.ccavenue.indiasdk.CCAvenueOrder
import com.ccavenue.indiasdk.CCAvenueSDK
import com.ccavenue.indiasdk.CCAvenueTransactionCallback
import com.ccavenue.indiasdk.model.CCAvenueResponseCallback
import com.google.gson.Gson
 
class CCAvenueWrapperActivity : AppCompatActivity(), CCAvenueTransactionCallback {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent()
    }

    private fun handleIntent() {
        
        val accessCode = intent.getStringExtra("accessCode") ?: ""
        val encRequest = intent.getStringExtra("encRequest") ?: ""
        val appColor = intent.getStringExtra("appColor") ?: "#1F46BD"
        val fontColor = intent.getStringExtra("fontColor") ?: "#FFFFFF"
        val paymentEnvironment = intent.getStringExtra("paymentEnvironment") ?: "production"
        val encryptionMode = intent.getStringExtra("encryptionMode") ?: "aes128"

        try {
            val orderDetails = CCAvenueOrder()
             
            orderDetails.accessCode = accessCode
            orderDetails.encRequest = encRequest
            orderDetails.appColor = appColor
            orderDetails.fontColor = fontColor
            orderDetails.paymentEnvironment = paymentEnvironment
            orderDetails.encryptionMode = encryptionMode


             CCAvenueSDK.initTransaction(this, orderDetails)

        } catch (e: Exception) {
            Log.e("CCAvenueWrapper", "Initialization Error", e)
            CcavenueIndiaSdkPlugin.onError?.invoke(e.toString())
            finish()
        }
    }

   override fun onTransactionResponse(response: CCAvenueResponseCallback) {
     
    val gson = Gson()
    
    
    val jsonString = gson.toJson(response)
    
    Log.d("CCAvenueWrapper", "JSON Response: $jsonString")
     
    CcavenueIndiaSdkPlugin.onSuccess?.invoke(jsonString)
    
    finish()
}
}