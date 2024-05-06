package com.eid.sdk

import android.graphics.Bitmap
import android.util.Base64
import android.util.Log
import com.facebook.react.bridge.Callback
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.WritableMap
import com.facebook.react.bridge.WritableNativeMap
import vn.jth.xverifysdk.activities.EidSDK
import vn.jth.xverifysdk.network.ApiService.APISERVICE
import java.io.ByteArrayOutputStream
import java.util.Calendar


class EidSdkModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  fun multiply(a: Double, b: Double, promise: Promise) {
    promise.resolve(a * b)
  }

  @ReactMethod
  fun initialize(apiKey: String, apiBaseUrl: String, customerCode: String) {
    APISERVICE.init(apiKey, apiBaseUrl, customerCode)
  }

  @ReactMethod
  fun start(callback:Callback) {
    EidSDK.startSDK(reactApplicationContext) { result ->
      // Gửi kết quả về cho React Native thông qua native module
      Log.e("EidSDK.startSDK",result.personOptionalDetails?.fullName.toString())
      val personMap: WritableMap = WritableNativeMap()
      val byteArrayOutputStream = ByteArrayOutputStream()
      result.face?.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
      val byteArray = byteArrayOutputStream.toByteArray()
      val base64 = Base64.encodeToString(byteArray, Base64.DEFAULT)
      personMap.putString("face",base64);
      personMap.putString("fullname", result.personOptionalDetails?.fullName)
      personMap.putString("gender",result.personOptionalDetails?.gender)
      personMap.putString("dateOfBirth",result.personOptionalDetails?.dateOfBirth)
      personMap.putString("age", result.personOptionalDetails?.dateOfBirth?.let { calcAge(it) })
      personMap.putString("eidNumber",result.personOptionalDetails?.eidNumber)
      personMap.putString("dateOfIssue",result.personOptionalDetails?.dateOfIssue)
      personMap.putString("dateOfExpiry",result.personOptionalDetails?.dateOfExpiry)
      personMap.putString("ethnicity",result.personOptionalDetails?.ethnicity)
      personMap.putString("religion",result.personOptionalDetails?.religion)
      personMap.putString("placeOfOrigin",result.personOptionalDetails?.placeOfOrigin)
      personMap.putString("placeOfResidence",result.personOptionalDetails?.placeOfResidence)
      personMap.putString("personalIdentification",result.personOptionalDetails?.personalIdentification)
      personMap.putString("fatherName",result.personOptionalDetails?.fatherName)
      personMap.putString("motherName",result.personOptionalDetails?.motherName)
      personMap.putString("spouseName",result.personOptionalDetails?.spouseName)
      personMap.putString("oldEidNumber",result.personOptionalDetails?.oldEidNumber)


      val res: WritableMap = WritableNativeMap()
      res.putMap("personOptionalDetails", personMap)

      callback.invoke(res);
    }
  }

  private fun calcAge(date: String): String {
    val sYear = date.substring(date.lastIndexOf("/") + 1)
    val calendar = Calendar.getInstance()
    val currentYear = calendar[Calendar.YEAR]
    try {
      val age = currentYear - sYear.toInt()
      return if (age > 0) age.toString() else "-"
    } catch (ex: NumberFormatException) {
    }
    return "-"
  }


  companion object {
    const val NAME = "EidSdkModule"
  }

}
