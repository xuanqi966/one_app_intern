import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String deviceId;

  DeviceCard({this.deviceName, this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/Frame@2x.png',
                height: 60,
                width: 60,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(deviceName,
                      style: Theme.of(context).textTheme.headline3),
                ),
                Text(
                  deviceId,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Container(
                  height: 25,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Tap to connect",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.black, fontSize: 12)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey[200]),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
