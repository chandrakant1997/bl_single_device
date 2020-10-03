import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String x = "0";

  if ( x = "0")
  {
  }
  String _data = '';
  bool _scanning = true;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    _bluetooth.devices.listen((device) {
      setState(() {
        // _data += device.name + ' (${device.address})\n';
        _data += device.name +
            ' (${device.address})' '\n' +
            DateTime.now().toString() +
            '\n';
        //print(_data);
      });
    });

    _bluetooth.startScan(
      pairedDevices: true,
    );

/*    setState(() {
      _scanning = true;
    });*/
/*    _bluetooth.scanStopped.listen((device) {
      setState(() {
        _scanning = true;
        _data += 'scan stopped\n';
        print(DateTime.now().toString());
      });
    }*/
  }

  @override // no need
  void dispose() {
    super.dispose();
    _data.length;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      _data,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    )
                    // Text("\n"),
                  ],
                ),
                // (_data != " ") ? MyWidget() : " ",
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RaisedButton(
                        child: Text(
                            _scanning ? 'restarted scanning' : 'Start scan'),
                        onPressed: () async {
                          try {
                            if (_scanning) {
                              await _bluetooth.startScan(pairedDevices: false);
                              debugPrint("scanning restarted");
                              setState(() {
                                // _data = '';
                                _scanning = true;
                              });
                            }

                            /*else {
                            await _bluetooth.startScan(pairedDevices: false);
                            debugPrint("scanning started");
                          }*/
                          } on PlatformException catch (e) {
                            debugPrint(e.toString());
                          }
                        }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
