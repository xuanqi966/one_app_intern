import 'package:flutter/material.dart';

import './pages/sheet_page.dart';
import './util/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: basicTheme(), home: SheetPage());
  }
}
