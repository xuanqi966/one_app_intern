import 'package:flutter/material.dart';

class PairingGuidePage extends StatefulWidget {
  @override
  _PairingGuidePageState createState() => _PairingGuidePageState();
}

class _PairingGuidePageState extends State<PairingGuidePage> {
  bool checkBoxValue = false;

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: _buildColumn(context),
      ),
    );
  }

  //==================== Utility functions======================================

  void searchProduct(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/devices');
  }

  //==================== Widget building functions==============================

  Widget _buildColumn(context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: Text("Pairing Product Guide",
                style: Theme.of(context).textTheme.headline1)),
        _buildCard(),
        Spacer(),
        _buildButton(context)
      ],
    );
  }

  Widget _buildCard() {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset('assets/images/Frame@3x.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Text(
                "Please ensure that your bluetooth and product are turned \"On\".",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: checkBoxValue,
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      setState(() {
                        checkBoxValue = value;
                      });
                    }),
                Text(
                  "Do not show again",
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(context) {
    return Container(
      width: 300,
      child: OutlinedButton(
        onPressed: () => searchProduct(context),
        child: Text(
          "Search for Product",
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
