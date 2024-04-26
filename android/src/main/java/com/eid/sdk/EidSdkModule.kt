package com.eid.sdk

import android.app.Activity
import android.content.Intent
import com.facebook.react.bridge.ActivityEventListener
import com.facebook.react.bridge.BaseActivityEventListener
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import vn.jth.xverifysdk.activities.verifyeid.VerifyEidMainActivity


class EidSdkModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext), ActivityEventListener {

  override fun getName(): String {
    return NAME
  }



//  override fun onActivityResult(activity: Activity, requestCode: Int, resultCode: Int, data: Intent?) {
//    if (requestCode == START_ACTIVITY_REQUEST_CODE) {
//      val success = resultCode == Activity.RESULT_OK
//      val result = Arguments.createMap().apply {
//        putBoolean("success", success)
//        // Add any additional data you want to pass back to JavaScript
//      }
//      reactApplicationContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
//        .emit("ActivityResultEvent", result)
//    }
//  }



  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  fun multiply(a: Double, b: Double, promise: Promise) {
    promise.resolve(a * b)
  }

  @ReactMethod
  fun initialize(apiKey: String, apiBaseUrl: String, customerCode: String) {
    val intent = Intent(reactApplicationContext, VerifyEidMainActivity::class.java)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    reactApplicationContext.startActivity(intent)



//    promise.resolve(a * b)
  }


  companion object {
    const val NAME = "EidSdkModule"
  }

  override fun onActivityResult(p0: Activity?, p1: Int, p2: Int, p3: Intent?) {
    TODO("Not yet implemented")
  }

  override fun onNewIntent(p0: Intent?) {
    TODO("Not yet implemented")
  }
}
