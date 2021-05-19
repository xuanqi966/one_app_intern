import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/device_card.dart';
import '../models/device.dart';
import '../data/DUMMY_DATA.dart';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  List<Device> _devices = new List<Device>();

  // for demoing purpose, not to be included in actual scenario
  int demo = 0;

  @override
  void initState() {
    super.initState();

    _refreshDevices();
  }

  Future _refreshDevices() async {
    await Future.delayed(Duration(seconds: 3)); // for demo purpose

    setState(() {
      _devices = DUMMY_DEVICES;
    });
  }

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
        body: (_devices.isEmpty)
            ? _buildPairing(context)
            : Container(
                padding: EdgeInsets.all(15),
                child: RefreshIndicator(
                  onRefresh: _refreshDevices,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return (index == _devices.length)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Pull down to refresh",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            )
                          : DeviceCard(
                              deviceName: _devices[index].deviceName,
                              deviceId: _devices[index].deviceId,
                            );
                    },
                    itemCount: _devices.length + 1,
                  ),
                )));
  }
}

Widget _buildPairing(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(
          radius: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Searching for Devices...",
              style: Theme.of(context).textTheme.bodyText1),
        )
      ],
    ),
  );
}
