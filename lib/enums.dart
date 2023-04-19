// ignore_for_file: constant_identifier_names

enum SunmiPrinter {
  SunmiNetPrinter,
  SunmiBlueToothPrinter,
  SunmiCloudPrinter,
  SunmiKitchenPrinter,
  SunmiYKPriner,
  SunmiNTPrinter,
}

enum BarCodeType {
  UPC_A,
  UPC_E,
  EAN13,
  EAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128,
}

enum PrintBitmapMode { Normal, DoubleWidth, DoubleHeight, Double }

enum PaperCutMode { FullCut, HalfCut, FeedCut }

enum AlignMode {
  Left(0),
  Center(1),
  Right(2);

  final int value;
  const AlignMode(this.value);
}

enum PrinterWidth { Esc58mm, Esc80mm }

enum PrinterStatus {
  Unknown(-1),
  Normal(0),
  LidOpen(1),
  OutOfPaper(2),
  OverHeat(4);

  final int value;
  const PrinterStatus(this.value);
  factory PrinterStatus.fromInt(int value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw "unknown enum value[$value]",
    );
  }
}
