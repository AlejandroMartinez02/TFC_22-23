import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends ChangeNotifier {
  SocketService() {
    config();
    print("MAMAHUEVO");
  }

  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  void config() {
    _socket = IO.io('http://192.168.1.105:3000', {
      'autoConnect': true,
      'transports': ['websocket']
    });
    _socket.onConnect((_) {
      print('connect');
    });
    _socket.onDisconnect((_) => print('disconnect'));
  }
}
