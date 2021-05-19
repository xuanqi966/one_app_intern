import 'package:flutter/material.dart';

import './pages/devices_page.dart';
import 'pages/register_success_page.dart';
import 'pages/pairing_guide_page.dart';
import './util/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: basicTheme(),
        // home: PairingGuidePage(),
        home: RegisterSuccessPage(deviceName: "uSmart 3"),
        // home: DevicePage(),
        routes: {
          '/pairing-guide': (ctx) => PairingGuidePage(),
          '/devices': (ctx) => DevicePage()
        });
  }
}
