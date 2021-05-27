import 'package:flutter/material.dart';
import 'package:one_app_intern/models/message.dart';
import 'dart:io';

import 'package:udp/udp.dart';

class ReceiverPage extends StatefulWidget {
  @override
  _ReceiverPageState createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  TextEditingController _controller = new TextEditingController();
  int _myPort;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Message> _messages = [];
  var udpReceiver;

  void udpReceive(int myPort) async {
    udpReceiver = await UDP.bind(Endpoint.any(port: Port(8082)));

    await udpReceiver.listen((datagram) {
      var message = String.fromCharCodes(datagram.data);
      var senderAddress = datagram.address.toString();

      _updateMsgList(senderAddress, message);
    });
  }

  void _updateMsgList(String senderAddress, String message) {
    setState(() {
      _messages.add(Message(senderAddress, message));
    });
  }

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
                child: _buildHeadings("Messages")),
            _buildMessageDisplay(),
            Container(
              width: 250,
              padding: EdgeInsets.all(20),
              child: OutlinedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                  },
                  child: Text('Receive',
                      style: Theme.of(context).textTheme.button)),
            )
          ],
        ),
      ),
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
          textInputAction: TextInputAction.next,
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
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5)),
      child: ListView.builder(
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
    title: Text(msg.senderAddress),
    subtitle: Text(msg.data),
  );
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
