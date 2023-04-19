import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enums.dart';
import 'sunmi_ext_printer_method_channel.dart';

abstract class SunmiExtPrinterPlatform extends PlatformInterface {
  /// Constructs a PrinterPlatform.
  SunmiExtPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static SunmiExtPrinterPlatform _instance = MethodChannelPrinter();

  /// The default instance of [SunmiExtPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPrinter].
  static SunmiExtPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SunmiExtPrinterPlatform] when
  /// they register themselves.
  static set instance(SunmiExtPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 1.
  Future<void> setPrinter(int printer, [String? address]) {
    throw UnimplementedError('setPrinter() has not been implemented.');
  }

  /// 2.
  Future<void> connectPrinter() {
    throw UnimplementedError('connectPrinter() has not been implemented.');
  }

  /// 3.
  Future<void> disconnectPrinter() {
    throw UnimplementedError('disconnectPrinter() has not been implemented.');
  }

  /// 4.
  Future<List<dynamic>?> findBleDevice() {
    throw UnimplementedError('findBleDevice() has not been implemented.');
  }

  /// 5.
  Future<bool> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  /// 6.
  Future<void> printerInit() {
    throw UnimplementedError('printerInit() has not been implemented.');
  }

  /// 7.
  Future<void> lineWrap(int n) {
    throw UnimplementedError('lineWrap() has not been implemented.');
  }

  /// 8.
  Future<void> pixelWrap(int n) {
    throw UnimplementedError('lineWrap() has not been implemented.');
  }

  /// 9.
  Future<void> flush() async {
    throw UnimplementedError('flush() has not been implemented.');
  }

  /// 10.
  Future<void> tab() async {
    throw UnimplementedError('tab() has not been implemented.');
  }

  /// 11.
  Future<void> setHorizontalTab(List<int> k) async {
    throw UnimplementedError('setHorizontalTab() has not been implemented.');
  }

  /// 12.
  Future<void> printText(String text) async {
    throw UnimplementedError('printText() has not been implemented.');
  }

  /// 13.
  Future<void> setGb18030CharSet(bool enable) async {
    throw UnimplementedError('setGb18030CharSet() has not been implemented.');
  }

  /// 14.
  Future<void> setPageTable(int n) async {
    throw UnimplementedError('setPageTable() has not been implemented.');
  }

  /// 15.
  Future<void> setInterCharSet(int n) async {
    throw UnimplementedError('setInterCharSet() has not been implemented.');
  }

  /// 18.
  Future<void> setFontZoom(int hori, int veri) async {
    throw UnimplementedError('setFontZoom() has not been implemented.');
  }

  /// 19.
  Future<void> setAlignMode(int type) async {
    throw UnimplementedError('setAlignMode() has not been implemented.');
  }

  /// 22.
  Future<void> enableUnderline(bool enable) async {
    throw UnimplementedError('enableUnderline() has not been implemented.');
  }

  /// 23.
  Future<void> enableBold(bool enable) async {
    throw UnimplementedError('enableBold() has not been implemented.');
  }

  /// 25.
  Future<void> setLineSpace(int value) async {
    throw UnimplementedError('setLineSpace() has not been implemented.');
  }

  /// 28.
  Future<void> printBarCode(
      String code, BarCodeType type, int width, int height, int hriPos) async {
    throw UnimplementedError('printBarCode() has not been implemented.');
  }

  /// 29.
  Future<void> printQrCode(String code, int modeSize, int errorlevel) async {
    throw UnimplementedError('printQrCode() has not been implemented.');
  }

  /// 30.
  Future<void> printBitmap(Uint8List bitmap, PrintBitmapMode mode) async {
    throw UnimplementedError('printBitmap() has not been implemented.');
  }

  /// 31.
  Future<void> printBitmap2(Uint8List bitmap, int mode) async {
    throw UnimplementedError('printBitmap2() has not been implemented.');
  }

  /// 32.
  Future<void> cutPaper(PaperCutMode m, int n) async {
    throw UnimplementedError('cutPaper() has not been implemented.');
  }

  /// 33.
  Future<void> printColumnsText(List<String> colsTextArr,
      List<int> colsWidthArr, List<int> colsAlign) async {
    throw UnimplementedError('printColumnsText() has not been implemented.');
  }

  /// 35.
  Future<void> sendRawData(Uint8List cmd) async {
    throw UnimplementedError('sendRawData() has not been implemented.');
  }

  /// 36.
  Future<int?> getPrinterStatus() async {
    throw UnimplementedError('getPrinterStatus() has not been implemented.');
  }
}
