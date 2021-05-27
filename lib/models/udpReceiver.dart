import 'dart:io';

import 'package:udp/udp.dart';

void udpReceive(int myPort) async {
  var receiver = await UDP.bind(Endpoint.any(port: Port(8082)));

  await receiver.listen((datagram) {
    var str = String.fromCharCodes(datagram.data);
    print(str);
  });
}
