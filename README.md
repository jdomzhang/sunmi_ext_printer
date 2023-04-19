# sunmi_ext_printer

Support `Sunmi` external printer, based on `Sunmi` official SDK documnet for `Sunmi` external printer.

## Main Features

- Print text
- Print image
- Print QrCode
- Print Barcode
- Print table
- Paper cut
- Paper feed
- Alignment:
  - left, center, right
- Styling:
  - bold, scale up in X, Y coordinate
- Send raw data
- Find bluetooth printer
  - For bluetooth permission, should be handled within Flutter App, for example, by using [`permission_handler`](https://pub.dev/packages/permission_handler)

## Examples

### Scan bluetooth for paired devices

```dart
Set<String> _bluetoothIds = {};

void findBleDevices() async {
    var res = await pos.findBleDevice();
    Set<String> ids = {};
    if (res != null) {
        for (var i = 0; i < res.length; i++) {
        ids.add('${res[i]}');
        }
    }

    setState(() {
        _bluetoothIds = ids;
    });
}

```

### Print texts

```dart

// Please **change** deviceID to the bluetooth address found by scanning result
var deviceID = '74:F7:F:FD:41:0D';

final pos = SunmiExtPrinter();
await pos.setPrinter(SunmiPrinter.SunmiBlueToothPrinter, deviceID);
await pos.connectPrinter();

await pos.setAlignMode(AlignMode.Center);
await pos.printText("Rubybear\n");

```

### Print QrCode

```dart
await pos.lineWrap();
await pos.printQrCode("https://edesoft.com/en.html");
await pos.lineWrap();
```

### Print image

```dart
var bytes = await rootBundle.load('images/logo.png');
var buf = bytes.buffer.asUint8List();
await pos.printImage(buf);
await pos.lineWrap();
```

- Make sure assets are defined in `pubspec.yaml`

```yaml
assets:
  - images/logo.png
```

- Make sure image file `images/logo.png` exists in the right folder.

- [Optional] You may resize image before send to printer, in case too big to print. Package [`image`](https://pub.dev/packages/image) is a good one to do that. E.g.

```dart
import 'package:image/image.dart' as img;

....

  Future<Uint8List> _convertImage(Uint8List imageBytes, int? printWidth,
      int? printHeight, bool invert) async {
    var cmd = img.Command()
      ..decodeImage(imageBytes)
      ..grayscale();
    await cmd.executeThread();

    if (printWidth == null && printHeight == null) {
      printWidth = 256;
    }

    cmd.copyResize(width: printWidth, height: printHeight);

    if (invert) {
      cmd.invert();
    }
    cmd.encodeBmp();
    await cmd.executeThread();

    var bitmapBytes = cmd.outputBytes ?? imageBytes;
    return bitmapBytes;
  }
```

### Print table

```dart
await pos.enableBold(true);
await pos.printColumnsText(["Item", "Qty", "Amt"], [18, 6, 8], [0, 2, 2]);

await pos.enableBold(false);
await pos.printColumnsText(["Carlsberg Bottle", "2", "20.00"], [18, 6, 8], [0, 2, 2]);
await pos.printColumnsText(["Milk 2L", "1", "3.50"], [18, 6, 8], [0, 2, 2]);

```

### Page cut

```dart
    await pos.cutPaper(PaperCutMode.FullCut);
```

### Flush

```dart
    await pos.flush();
```

## SDK Document

- [Sumni External Printer SDK Document](https://file.cdn.sunmi.com/SUNMIDOCS/%E5%95%86%E7%B1%B3%E5%A4%96%E6%8E%A5%E6%89%93%E5%8D%B0%E6%9C%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%96%87%E6%A1%A3-2112.pdf)
