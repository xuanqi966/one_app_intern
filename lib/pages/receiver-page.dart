import 'package:flutter/material.dart';
import 'package:one_app_intern/models/message.dart';

import 'package:udp/udp.dart';

class ReceiverPage extends StatefulWidget {
  @override
  _ReceiverPageState createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  //========================= Global variables =========================//
  int _myPort;
  var udpReceiver;
  bool isReceiving = false;
  // Progress bar circular, receiver open, button change
  List<Message> _messages = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //========================= Helper functions =========================//
  void udpReceive(int myPort) async {
    udpReceiver = await UDP.bind(Endpoint.any(port: Port(myPort)));

    await udpReceiver.listen((datagram) {
      var message = String.fromCharCodes(datagram.data);
      var senderAddress = datagram.address.address;
      _updateMsgList(senderAddress, message);
    });
  }

  void _updateMsgList(String senderAddress, String message) {
    setState(() {
      _messages.add(Message(senderAddress, message, DateTime.now()));
    });
  }

  void _receiveHandler() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      isReceiving = true;
    });
    udpReceive(_myPort);
  }

  void _terminateHandler() {
    setState(() {
      isReceiving = false;
      _messages = [];
      _myPort = null;
    });
    udpReceiver.close();
    _formKey.currentState.reset();
  }

  //========================= Widget building =========================//
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildHeadings("UDP Receiver"),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomLeft,
                child: _buildHeadings("My Port")),
            _buildInputField(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    _buildHeadings("Messages"),
                    isReceiving
                        ? Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                  ],
                )),
            _buildMessageDisplay(),
            (isReceiving)
                ? _buildButton("Stop", _terminateHandler)
                : _buildButton("Receive", _receiveHandler),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Function onPressed) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(20),
      child: OutlinedButton(
          onPressed: onPressed,
          child: Text(text, style: Theme.of(context).textTheme.button)),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              labelText: 'Port Number',
              hintText: 'My Port Number',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(fontSize: 16)),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          validator: (String value) {
            if (!isNumeric(value)) {
              return 'Please enter a numerical Port Number';
            }
            return null;
          },
          onSaved: (String value) {
            _myPort = int.parse(value);
          }),
    );
  }

  Widget _buildHeadings(String text) {
    return Text(text, style: Theme.of(context).textTheme.headline1);
  }

  Widget _buildMessageDisplay() {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (ctx, index) {
          return _buildMessageListTile(_messages[index]);
        },
      ),
    );
  }
}

Widget _buildMessageListTile(Message msg) {
  return ListTile(
    title: Text(msg.data),
    subtitle: Text(msg.senderAddress + "   " + msg.dateTime.toString()),
  );
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
