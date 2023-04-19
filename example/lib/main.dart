import 'package:flutter/material.dart';

import 'package:sunmi_ext_printer/enums.dart';
import 'package:sunmi_ext_printer/sunmi_ext_printer.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart' show PlatformException, rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Set<String> _bluetoothIds = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Printer example app'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                onPressed: () => permitBleThenFind(context),
                icon: const Icon(Icons.search),
                label: const Text("Scan Printers")),
            for (var id in _bluetoothIds) BluetoothRow(id),
          ],
        )),
      ),
    );
  }

  void permitBleThenFind(BuildContext context) async {
    var ok = await Permission.bluetooth.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted;
    if (ok) {
      findBleDevices();
    }
  }

  void findBleDevices() async {
    var res = await SunmiExtPrinter().findBleDevice();
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
}

class BluetoothRow extends StatefulWidget {
  final String deviceID;
  const BluetoothRow(this.deviceID, {super.key});

  @override
  State<BluetoothRow> createState() => _BluetoothRowState();
}

class _BluetoothRowState extends State<BluetoothRow> {
  bool _isRunning = false;

  _BluetoothRowState();

  Future<void> _print() async {
    setState(() {
      _isRunning = true;
    });
    try {
      printReceipt(widget.deviceID);
    } on PlatformException catch (ex) {
      _showMyDialog(context, 'Error', ex.message);
    } catch (ex) {
      _showMyDialog(context, 'Unknown Error', ex);
    } finally {
      setState(() {
        _isRunning = false;
      });
    }
  }

  Future<void> printReceipt(deviceID) async {
    final pos = SunmiExtPrinter();
    await pos.setPrinter(SunmiPrinter.SunmiBlueToothPrinter, deviceID);
    await pos.connectPrinter();

    await pos.setAlignMode(AlignMode.Center);
    await pos.setFontZoom(2, 2);
    await pos.enableBold(true);
    await pos.printText("Rubybear\n");
    await pos.lineWrap();

    await pos.setFontZoom(1, 1);
    await pos.enableBold(false);
    await pos.printText("1888 Super Road\nWanda Plaza\nShanghai, China\n");
    await pos.lineWrap();

    var bytes = await rootBundle.load('images/logo.png');
    var buf = bytes.buffer.asUint8List();
    await pos.printImage(buf);
    await pos.lineWrap();

    await pos.enableBold(true);
    await pos.printText("Retail Invoice\n");
    await pos.lineWrap();

    await pos.enableBold(false);
    await pos.setAlignMode(AlignMode.Left);
    await pos.printText("Date: 09/15/2022, 15:35\n");
    await pos.printText("Payment Mode: AliPay\n");
    await pos.printText("--------------------------------\n");

    await pos.enableBold(true);
    await pos.printColumnsText(["Item", "Qty", "Amt"], [18, 6, 8], [0, 2, 2]);

    await pos.enableBold(false);
    await pos.printColumnsText(
        ["Carlsberg Bottle", "2", "20.00"], [18, 6, 8], [0, 2, 2]);
    await pos.printColumnsText(["Milk 2L", "1", "3.50"], [18, 6, 8], [0, 2, 2]);
    await pos
        .printColumnsText(["Ice Cream", "5", "20.00"], [18, 6, 8], [0, 2, 2]);

    await pos.printText("--------------------------------\n");
    await pos.enableBold(true);
    await pos.printColumnsText(["TOTAL", "43.50"], [16, 16], [0, 2]);

    await pos.setAlignMode(AlignMode.Center);
    await pos.enableBold(false);
    await pos.lineWrap();
    await pos
        .printText("This is your official receipt\nThank you come again!\n");
    await pos.printText("Please scan and check more\n");
    await pos.lineWrap();
    await pos.printQrCode("https://edesoft.com/en.html");

    await pos.lineWrap(n: 4);
    await pos.cutPaper(PaperCutMode.FullCut);
    await pos.flush();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.deviceID),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: _isRunning ? null : _print,
                child:
                    Text(_isRunning ? 'Connecting...' : 'Connect and Print')),
          ],
        )));
  }
}

Future<void> _showMyDialog(BuildContext context, String title, body,
    [String okText = "OK", cancelText = "Cancel", bool showCancel = false]) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        Visibility(
            visible: showCancel,
            child: TextButton(
              onPressed: () => Navigator.pop(context, cancelText),
              child: Text(cancelText),
            )),
        TextButton(
          onPressed: () => Navigator.pop(context, okText),
          child: Text(okText),
        ),
      ],
    ),
  );
}
