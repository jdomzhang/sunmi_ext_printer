import 'dart:typed_data';

import 'enums.dart';
import 'sunmi_ext_printer_platform_interface.dart';

class SunmiExtPrinter {
  /// 1.
  Future<void> setPrinter(SunmiPrinter printer, [String? address]) {
    return SunmiExtPrinterPlatform.instance.setPrinter(printer.index, address);
  }

  /// 2.
  Future<void> connectPrinter() {
    return SunmiExtPrinterPlatform.instance.connectPrinter();
  }

  /// 3.
  Future<void> disconnectPrinter() async {
    return SunmiExtPrinterPlatform.instance.disconnectPrinter();
  }

  /// 4.
  Future<List<dynamic>?> findBleDevice() {
    return SunmiExtPrinterPlatform.instance.findBleDevice();
  }

  /// 5.
  Future<bool> isConnected() {
    return SunmiExtPrinterPlatform.instance.isConnected();
  }

  /// 6.
  Future<void> printerInit() {
    return SunmiExtPrinterPlatform.instance.printerInit();
  }

  /// 7.
  Future<void> lineWrap({int n = 1}) {
    return SunmiExtPrinterPlatform.instance.lineWrap(n);
  }

  /// 8.
  Future<void> pixelWrap(int n) {
    return SunmiExtPrinterPlatform.instance.pixelWrap(n);
  }

  /// 9.
  Future<void> flush() {
    return SunmiExtPrinterPlatform.instance.flush();
  }

  /// 10.
  Future<void> tab() {
    return SunmiExtPrinterPlatform.instance.tab();
  }

  /// 11.
  Future<void> setHorizontalTab(List<int> k) {
    return SunmiExtPrinterPlatform.instance.setHorizontalTab(k);
  }

  /// 12.
  Future<void> printText(String text) {
    return SunmiExtPrinterPlatform.instance.printText(text);
  }

  /// 13.
  Future<void> setGb18030CharSet(bool set) async {
    return SunmiExtPrinterPlatform.instance.setGb18030CharSet(set);
  }

  /// 14.
  Future<void> setPageTable(int n) async {
    return SunmiExtPrinterPlatform.instance.setPageTable(n);
  }

  /// 15.
  Future<void> setInterCharSet(int n) async {
    return SunmiExtPrinterPlatform.instance.setInterCharSet(n);
  }

  /// 18.
  Future<void> setFontZoom(int hori, int veri) async {
    return SunmiExtPrinterPlatform.instance.setFontZoom(hori, veri);
  }

  /// 19.
  Future<void> setAlignMode(AlignMode mode) async {
    return SunmiExtPrinterPlatform.instance.setAlignMode(mode.value);
  }

  /// 22.
  Future<void> enableUnderline(bool enable) async {
    return SunmiExtPrinterPlatform.instance.enableUnderline(enable);
  }

  /// 23.
  Future<void> enableBold(bool enable) async {
    return SunmiExtPrinterPlatform.instance.enableBold(enable);
  }

  /// 25.
  Future<void> setLineSpace(int value) async {
    return SunmiExtPrinterPlatform.instance.setLineSpace(value);
  }

  /// 28.
  Future<void> printBarCode(String code,
      {BarCodeType type = BarCodeType.CODE39,
      int width = 3,
      int height = 100,
      int hriPos = 0}) {
    return SunmiExtPrinterPlatform.instance
        .printBarCode(code, type, width, height, hriPos);
  }

  /// 29.
  Future<void> printQrCode(String code,
      {int modeSize = 10, int errorlevel = 1}) {
    return SunmiExtPrinterPlatform.instance
        .printQrCode(code, modeSize, errorlevel);
  }

  /// 30.
  Future<void> printImage(Uint8List imageBytes,
      {PrintBitmapMode mode = PrintBitmapMode.Normal,
      int? printWidth,
      int? printHeight,
      bool invert = false}) async {
    return SunmiExtPrinterPlatform.instance.printBitmap(imageBytes, mode);
  }

  /// 31.
  Future<void> printImage2(Uint8List imageBytes,
      {int mode = 0,
      int? printWidth,
      int? printHeight,
      bool invert = false}) async {
    return SunmiExtPrinterPlatform.instance.printBitmap2(imageBytes, mode);
  }

  /// 32.
  Future<void> cutPaper(PaperCutMode m, {int n = 0}) async {
    return SunmiExtPrinterPlatform.instance.cutPaper(m, n);
  }

  /// 33.
  Future<void> printColumnsText(
    List<String> colsTextArr,
    List<int> colsWidthArr,
    List<int> colsAlign,
  ) async {
    return SunmiExtPrinterPlatform.instance
        .printColumnsText(colsTextArr, colsWidthArr, colsAlign);
  }

  /// 35.
  Future<void> sendRawData(Uint8List cmd) async {
    return SunmiExtPrinterPlatform.instance.sendRawData(cmd);
  }

  /// 36.
  Future<PrinterStatus> getPrinterStatus() async {
    var status =
        await SunmiExtPrinterPlatform.instance.getPrinterStatus() ?? -1;
    return PrinterStatus.fromInt(status);
  }
}
