import 'package:flutter/material.dart';

class SheetPage extends StatefulWidget {
  @override
  _SheetPageState createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
  String currentButton = "Please press some buttons from bottom sheet!";

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentButton,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 300,
                child: OutlinedButton(
                  onPressed: () => _modalTrigger(context),
                  child: Text(
                    "Activate Bottom Sheet",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _modalTrigger(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: _buildBottomSheet(context));
        });
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      color: Color(0XFF737373),
      height: 320,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(
                "About this device",
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: pressAboutDevice,
            ),
            Divider(
              height: 0,
              indent: 18,
              endIndent: 18,
              thickness: 2,
              color: Colors.grey[200],
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(
                "Send feedback",
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: pressSendFeedback,
            ),
            Divider(
              height: 0,
              indent: 18,
              endIndent: 18,
              thickness: 2,
              color: Colors.grey[200],
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(
                "Help",
                style: Theme.of(context).textTheme.headline4,
              ),
              onTap: pressHelp,
            ),
            Divider(
              height: 0,
              indent: 18,
              endIndent: 18,
              thickness: 2,
              color: Colors.grey[200],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 300,
              child: OutlinedButton(
                  onPressed: pressUnpair,
                  child: Text(
                    "Unpair Device",
                    style: Theme.of(context).textTheme.button,
                  )),
            )
          ],
        ),
      ),
    );
  }

  void pressAboutDevice() {
    setState(() {
      currentButton = "\"About this device\" has been pressed!";
    });
    Navigator.pop(context);
  }

  void pressSendFeedback() {
    setState(() {
      currentButton = "\"Send feedback\" has been pressed!";
    });
    Navigator.pop(context);
  }

  void pressHelp() {
    setState(() {
      currentButton = "\"Help\" has been pressed!";
    });
    Navigator.pop(context);
  }

  void pressUnpair() {
    setState(() {
      currentButton = "\"Unpair Device\" has been pressed!";
    });
    Navigator.pop(context);
  }
}
