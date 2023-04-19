package com.edesoft.sunmi_ext_printer

import android.content.Context
import android.graphics.BitmapFactory
import android.util.Log
import androidx.annotation.NonNull
import com.sunmi.externalprinterlibrary.api.ConnectCallback
import com.sunmi.externalprinterlibrary.api.SunmiPrinter
import com.sunmi.externalprinterlibrary.api.SunmiPrinterApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SunmiExtPrinterPlugin */
class SunmiExtPrinterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "printer")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    try {
      when (call.method) {
        "setPrinter" -> setPrinter(call, result) // 1.
        "connectPrinter" -> connectPrinter(call, result) // 2.
        "disconnectPrinter" -> disconnectPrinter(call, result) // 3.
        "findBleDevice" -> findBleDevice(call, result) // 4.
        "isConnected" -> isConnected(call, result) // 5.
        "printerInit" -> printerInit(call, result) // 6.
        "lineWrap" -> lineWrap(call, result) // 7.
        "pixelWrap" -> pixelWrap(call, result) // 8.
        "flush" -> flush(call, result) // 9.
        "tab" -> tab(call, result) // 10.
        "setHorizontalTab" -> setHorizontalTab(call, result) // 11.
        "printText" -> printText(call, result) // 12.
        "setGb18030CharSet" -> setGb18030CharSet(call, result) // 13.
        "setPageTable" -> setPageTable(call, result) // 14.
        "setInterCharSet" -> setInterCharSet(call, result) // 15.
        "setFontZoom" -> setFontZoom(call, result) // 18.
        "setAlignMode" -> setAlignMode(call, result) // 19.
        "enableUnderline" -> enableUnderline(call, result) // 22.
        "enableBold" -> enableBold(call, result) // 23.
        "setLineSpace" -> setLineSpace(call, result) // 25.
        "printBarCode" -> printBarCode(call, result) // 28.
        "printQrCode" -> printQrCode(call, result) // 29.
        "printBitmap" -> printBitmap(call, result) // 30.
        "printBitmap2" -> printBitmap2(call, result) // 31.
        "cutPaper" -> cutPaper(call, result) // 32.
        "printColumnsText" -> printColumnsText(call, result) // 33.
        "sendRawData" -> sendRawData(call, result) // 35.
        "getPrinterStatus" -> getPrinterStatus(call, result) // 36.
        else -> result.notImplemented()
      }
    } catch (ex: Exception) {
      result.error(call.method, ex.message, ex)
    }
  }

  /// 1.
  private fun setPrinter(call: MethodCall, result: Result) {
    val sunmiPrinterInput = call.argument<Int>("sunmiPrinter")
    val addressInput = call.argument<String>("address")

    var sunmiPrinter = when (sunmiPrinterInput) {
      null -> throw Exception("[sunmiPrinter] should not be null")
      0 -> SunmiPrinter.SunmiNetPrinter
      1 -> SunmiPrinter.SunmiBlueToothPrinter
      2 -> SunmiPrinter.SunmiCloudPrinter
      3 -> SunmiPrinter.SunmiKitchenPrinter
      4 -> SunmiPrinter.SunmiYKPriner
      5 -> SunmiPrinter.SunmiNTPrinter
      else -> throw Exception("unknown [sunmiPrinter:$sunmiPrinterInput]")
    }

    if (addressInput != null && addressInput != "") {
      SunmiPrinterApi.getInstance().setPrinter(sunmiPrinter, addressInput)
    } else {
      SunmiPrinterApi.getInstance().setPrinter(sunmiPrinter)
    }

    result.success(null)
  }

  /// 2.
  private fun connectPrinter(call: MethodCall, result: Result) {
    var callback = object : ConnectCallback {
      override fun onFound() {
        Log.d("print3", "onFound")
//        result.success(null)
      }

      override fun onUnfound() {
        Log.d("print3", "onUnfound")
        result.error("BlueToothError", "could not connect", null)
      }

      override fun onConnect() {
        Log.d("print3", "onConnect")
        result.success(null)
      }

      override fun onDisconnect() {
        Log.d("print3", "onDisconnect")
//        result.success(null)
      }
    }

    // if already connected, do not connect again
    val ok = SunmiPrinterApi.getInstance().isConnected
    if (ok) {
      return result.success(null)
    }

    SunmiPrinterApi.getInstance().connectPrinter(context, callback)
  }

  /// 3.
  private fun disconnectPrinter(call: MethodCall, result: Result) {
    SunmiPrinterApi.getInstance().disconnectPrinter(context)
    result.success(null)
  }

  /// 4.
  private fun findBleDevice(call: MethodCall, result: Result) {
    val res = SunmiPrinterApi.getInstance().findBleDevice(context)
    result.success(res)
  }

  /// 5.
  private fun isConnected(call: MethodCall, result: Result) {
    val res = SunmiPrinterApi.getInstance().isConnected
    result.success(res)
  }

  /// 6.
  private fun printerInit(call: MethodCall, result: Result) {
    SunmiPrinterApi.getInstance().printerInit()
    result.success(null)
  }

  /// 7.
  private fun lineWrap(call: MethodCall, result: Result) {
    val n = call.argument<Int>("n") ?: 0

    SunmiPrinterApi.getInstance().lineWrap(n)
    result.success(null)
  }

  /// 8.
  private fun pixelWrap(call: MethodCall, result: Result) {
    val n = call.argument<Int>("n") ?: 0

    SunmiPrinterApi.getInstance().pixelWrap(n)
    result.success(null)
  }

  /// 9.
  private fun flush(call: MethodCall, result: Result) {
    SunmiPrinterApi.getInstance().flush()
    result.success(null)
  }

  /// 10.
  private fun tab(call: MethodCall, result: Result) {
    SunmiPrinterApi.getInstance().tab()
    result.success(null)
  }

  /// 11.
  private fun setHorizontalTab(call: MethodCall, result: Result) {
    val k = call.argument<List<Int>>("k") ?: listOf()

    SunmiPrinterApi.getInstance().setHorizontalTab(k.toIntArray())
    result.success(null)
  }

  /// 12.
  private fun printText(call: MethodCall, result: Result) {
    val text = call.argument<String>("text") ?: ""

    SunmiPrinterApi.getInstance().printText(text)
    result.success(null)
  }

  /// 13.
  private fun setGb18030CharSet(call: MethodCall, result: Result) {
    val set = call.argument<Boolean>("set") ?: true

    SunmiPrinterApi.getInstance().setGb18030CharSet(set)
    result.success(null)
  }

  /// 14.
  private fun setPageTable(call: MethodCall, result: Result) {
    val n = call.argument<Int>("n") ?: 0

    SunmiPrinterApi.getInstance().setPageTable(n)
    result.success(null)
  }

  /// 15.
  private fun setInterCharSet(call: MethodCall, result: Result) {
    val n = call.argument<Int>("n") ?: 0

    SunmiPrinterApi.getInstance().setInterCharSet(n)
    result.success(null)
  }

  /// 18.
  private fun setFontZoom(call: MethodCall, result: Result) {
    val hori = call.argument<Int>("hori") ?: 1
    val veri = call.argument<Int>("veri") ?: 1

    SunmiPrinterApi.getInstance().setFontZoom(hori, veri)
    result.success(null)
  }

  /// 19.
  private fun setAlignMode(call: MethodCall, result: Result) {
    val type = call.argument<Int>("type") ?: 0

    SunmiPrinterApi.getInstance().setAlignMode(type)
    result.success(null)
  }

  /// 22.
  private fun enableUnderline(call: MethodCall, result: Result) {
    val enable = call.argument<Boolean>("enable") ?: false

    SunmiPrinterApi.getInstance().enableUnderline(enable)
    result.success(null)
  }

  /// 23.
  private fun enableBold(call: MethodCall, result: Result) {
    val enable = call.argument<Boolean>("enable") ?: false

    SunmiPrinterApi.getInstance().enableBold(enable)
    result.success(null)
  }

  /// 25.
  private fun setLineSpace(call: MethodCall, result: Result) {
    val value = call.argument<Int>("value") ?: 0

    SunmiPrinterApi.getInstance().setLineSpace(value)
    result.success(null)
  }

  /// 28.
  private fun printBarCode(call: MethodCall, result: Result) {
    val code = call.argument<String>("code") ?: ""
    val type = call.argument<Int>("type") ?: 0
    val width = call.argument<Int>("width") ?: 2
    val height = call.argument<Int>("height") ?: 10
    val hriPos = call.argument<Int>("hriPos") ?: 0

    SunmiPrinterApi.getInstance().printBarCode(code, type, width, height, hriPos)
    result.success(null)
  }

  /// 29.
  private fun printQrCode(call: MethodCall, result: Result) {
    val code = call.argument<String>("code") ?: ""
    val modeSize = call.argument<Int>("modeSize") ?: 10
    val errorlevel = call.argument<Int>("errorlevel") ?: 1

    SunmiPrinterApi.getInstance().printQrCode(code, modeSize, errorlevel)
    result.success(null)
  }

  /// 30.
  private fun printBitmap(call: MethodCall, result: Result) {
    var bytes = call.argument<ByteArray>("bitmap") ?: ByteArray(0);
    val mode = call.argument<Int>("mode") ?: 0

    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
    SunmiPrinterApi.getInstance().printBitmap(bitmap, mode)
    result.success(null)
  }

  /// 31.
  private fun printBitmap2(call: MethodCall, result: Result) {
    var bytes = call.argument<ByteArray>("bitmap") ?: ByteArray(0);
    val mode = call.argument<Int>("mode") ?: 0

    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
    SunmiPrinterApi.getInstance().printBitmap2(bitmap, mode)
    result.success(null)
  }

  /// 32.
  private fun cutPaper(call: MethodCall, result: Result) {
    var m = call.argument<Int>("m") ?: 0
    val n = call.argument<Int>("n") ?: 0

    SunmiPrinterApi.getInstance().cutPaper(m, n)
    result.success(null)
  }

  /// 33.
  private fun printColumnsText(call: MethodCall, result: Result) {
    var colsTextArr = call.argument<List<String>>("colsTextArr") ?: listOf()
    var colsWidthArr = call.argument<List<Int>>("colsWidthArr") ?: listOf()
    var colsAlign = call.argument<List<Int>>("colsAlign") ?: listOf()

    SunmiPrinterApi.getInstance().printColumnsText(
      colsTextArr.toTypedArray(),
      colsWidthArr.toIntArray(),
      colsAlign.toIntArray()
    )
    result.success(null)
  }

  /// 35.
  private fun sendRawData(call: MethodCall, result: Result) {
    var cmd = call.argument<ByteArray>("cmd") ?: ByteArray(0);

    SunmiPrinterApi.getInstance().sendRawData(cmd.toTypedArray().toByteArray());
    result.success(null)
  }

  /// 36.
  private fun getPrinterStatus(call: MethodCall, result: Result) {
    val status = SunmiPrinterApi.getInstance().printerStatus;
    result.success(status)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
