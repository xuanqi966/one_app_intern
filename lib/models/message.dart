import 'dart:io';

class Message {
  final String senderAddress;
  final String data;
  final DateTime dateTime;

  Message(this.senderAddress, this.data, this.dateTime);
}
