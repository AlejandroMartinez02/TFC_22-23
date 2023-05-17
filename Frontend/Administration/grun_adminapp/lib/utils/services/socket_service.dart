import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  ServerStatus get serverStatus => _serverStatus;

  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  void connect() {
    _socket = IO.io(Constants.httpSocket, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    socket.on('mensaje-nuevo', (data) {
      print(data);
    });
  }

  void emit() {
    socket.emit('usuarios');
  }
}
