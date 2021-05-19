import 'dart:io';

import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatelessWidget {
  final String deviceName;

  RegisterSuccessPage({this.deviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/osim_logo.png'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildColumn(context),
    );
  }

  //==================== Utility functions======================================

  void startPairing(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/pairing-guide',
        arguments: {'deviceName': this.deviceName});
  }

  //==================== Widget building functions==============================

  Widget _buildColumn(context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            deviceName + " is successfully registered under your account.",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          Image.asset('assets/images/Frame@2x.png'),
          _buildButton(context)
        ],
      ),
    );
  }

  Widget _buildButton(context) {
    return Container(
      width: 300,
      child: OutlinedButton(
        onPressed: () => startPairing(context),
        child: Text(
          "Start Pairing",
          style: Theme.of(context).textTheme.button,
        ),
        //style: Theme.of(context).outlinedButtonTheme
      ),
    );
  }
}
