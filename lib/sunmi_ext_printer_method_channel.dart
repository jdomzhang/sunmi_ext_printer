import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'enums.dart';
import 'sunmi_ext_printer_platform_interface.dart';

/// An implementation of [PrinterPlatform] that uses method channels.
class MethodChannelPrinter extends SunmiExtPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('printer');

  @override
  Future<void> setPrinter(int printer, [String? address]) async {
    await methodChannel.invokeMethod<void>('setPrinter', <String, dynamic>{
      'sunmiPrinter': printer,
      'address': address ?? '',
    });
  }

  @override
  Future<void> connectPrinter() async {
    await methodChannel.invokeMethod<void>('connectPrinter');
  }

  @override
  Future<void> disconnectPrinter() async {
    await methodChannel.invokeMethod<void>('disconnectPrinter');
  }

  @override
  Future<List<dynamic>?> findBleDevice() async {
    return await methodChannel.invokeMethod<List<dynamic>>('findBleDevice');
  }

  @override
  Future<bool> isConnected() async {
    return await methodChannel.invokeMethod<bool>('isConnected') ?? false;
  }

  @override
  Future<void> printerInit() async {
    await methodChannel.invokeMethod<void>('printerInit');
  }

  @override
  Future<void> lineWrap(int n) async {
    await methodChannel.invokeMethod<void>('lineWrap', <String, dynamic>{
      'n': n,
    });
  }

  @override
  Future<void> pixelWrap(int n) async {
    await methodChannel.invokeMethod<void>('pixelWrap', <String, dynamic>{
      'n': n,
    });
  }

  @override
  Future<void> flush() async {
    await methodChannel.invokeMethod<void>('flush');
  }

  @override
  Future<void> tab() async {
    await methodChannel.invokeMethod<void>('tab');
  }

  @override
  Future<void> setHorizontalTab(List<int> k) async {
    await methodChannel
        .invokeMethod<void>('setHorizontalTab', <String, dynamic>{
      'k': k,
    });
  }

  @override
  Future<void> setGb18030CharSet(bool enable) async {
    await methodChannel
        .invokeMethod<void>('setGb18030CharSet', <String, dynamic>{
      'enable': enable,
    });
  }

  @override
  Future<void> setPageTable(int n) async {
    await methodChannel.invokeMethod<void>('setPageTable', <String, dynamic>{
      'n': n,
    });
  }

  @override
  Future<void> setInterCharSet(int n) async {
    await methodChannel.invokeMethod<void>('setInterCharSet', <String, dynamic>{
      'n': n,
    });
  }

  @override
  Future<void> printText(String text) async {
    await methodChannel.invokeMethod<void>('printText', <String, dynamic>{
      'text': text,
    });
  }

  @override
  Future<void> setFontZoom(int hori, int veri) async {
    await methodChannel.invokeMethod<void>('setFontZoom', <String, dynamic>{
      'hori': hori,
      'veri': veri,
    });
  }

  @override
  Future<void> setAlignMode(int type) async {
    await methodChannel.invokeMethod<void>('setAlignMode', <String, dynamic>{
      'type': type,
    });
  }

  @override
  Future<void> enableUnderline(bool enable) async {
    await methodChannel.invokeMethod<void>('enableUnderline', <String, dynamic>{
      'enable': enable,
    });
  }

  @override
  Future<void> enableBold(bool enable) async {
    await methodChannel.invokeMethod<void>('enableBold', <String, dynamic>{
      'enable': enable,
    });
  }

  @override
  Future<void> setLineSpace(int value) async {
    await methodChannel.invokeMethod<void>('setLineSpace', <String, dynamic>{
      'value': value,
    });
  }

  @override
  Future<void> printBarCode(
      String code, BarCodeType type, int width, int height, int hriPos) async {
    await methodChannel.invokeMethod<void>('printBarCode', <String, dynamic>{
      'code': code,
      'type': type.index, // Convert to int
      'width': width,
      'height': height,
      'hriPos': hriPos,
    });
  }

  @override
  Future<void> printQrCode(String code, int modeSize, int errorlevel) async {
    await methodChannel.invokeMethod<void>('printQrCode', <String, dynamic>{
      'code': code,
      'modeSize': modeSize,
      'errorlevel': errorlevel,
    });
  }

  @override
  Future<void> printBitmap(Uint8List bitmap, PrintBitmapMode mode) async {
    await methodChannel.invokeMethod<void>('printBitmap', <String, dynamic>{
      'bitmap': bitmap,
      'mode': mode.index,
    });
  }

  @override
  Future<void> printBitmap2(Uint8List bitmap, int mode) async {
    await methodChannel.invokeMethod<void>('printBitmap2', <String, dynamic>{
      'bitmap': bitmap,
      'mode': mode,
    });
  }

  @override
  Future<void> cutPaper(PaperCutMode m, int n) async {
    await methodChannel.invokeMethod<void>('cutPaper', <String, dynamic>{
      'm': m.index,
      'n': n,
    });
  }

  @override
  Future<void> printColumnsText(List<String> colsTextArr,
      List<int> colsWidthArr, List<int> colsAlign) async {
    await methodChannel
        .invokeMethod<void>('printColumnsText', <String, dynamic>{
      'colsTextArr': colsTextArr,
      'colsWidthArr': colsWidthArr,
      'colsAlign': colsAlign,
    });
  }

  @override
  Future<void> sendRawData(Uint8List cmd) async {
    await methodChannel.invokeMethod<void>('sendRawData', <String, dynamic>{
      'cmd': cmd,
    });
  }

  @override
  Future<int?> getPrinterStatus() async {
    return await methodChannel.invokeMethod<int>('getPrinterStatus');
  }
}
