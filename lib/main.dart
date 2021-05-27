import 'package:flutter/material.dart';
import 'package:one_app_intern/pages/tab-page.dart';

import './util/theme.dart';
import 'pages/sender-page.dart';

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
      // home: RegisterSuccessPage(deviceName: "uSmart 3"),
      // home: DevicePage(),
      home: TabPage(),
    );
  }
}
