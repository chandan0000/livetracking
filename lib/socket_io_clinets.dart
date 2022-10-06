import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    try {
      socket = IO.io('http://172.18.0.66:3700', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': 'false',
      });
      socket!.connect();
      socket!.onConnect((data) => {log('connected'), print(socket!.id)});
    } catch (e) {
      log(e.toString());
    }
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}




  // Future<void> initSocket() async {
  //   try {
  //     socket = IO.io('http://172.18.0.66:3700', <String, dynamic>{
  //       'transports': ['websocket'],
  //       'autoConnect': 'false',
  //     });
  //     socket.connect();
  //     socket.onConnect((data) => {log('connected'), print(socket.id)});
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }