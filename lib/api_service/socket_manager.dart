// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  static const String _socketUrl = "ws://13.214.193.32:3000/vps-chat/ws";

  SocketManager._internal() {
    isConnected = true;
    channel.stream.listen((data) {
      _handleMessage(data);
      // log(data);
    });
    channel.sink.done.then((_) {
      isConnected = false;
      log("WebSocket connection closed.");
    });
  }
  static final SocketManager _instance = SocketManager._internal();

  static SocketManager get instance => _instance;

  // static final SocketManager _instance = SocketManager._internal();
  // factory SocketManager() {
  //   return _instance;
  // }

  // SocketManager._internal() {
  //   // channel = IOWebSocketChannel.connect(_socketUrl);
  // isConnected = true;
  // channel.stream.listen((data) {
  //   _handleMessage(data);
  //   // log(data);
  // });
  // channel.sink.done.then((_) {
  //   isConnected = false;
  //   log("WebSocket connection closed.");
  // });
  // }

  final WebSocketChannel channel = IOWebSocketChannel.connect(_socketUrl);
  late bool isConnected; // Thêm một biến để theo dõi trạng thái kết nối.
  final List<Function(dynamic)> _messageListeners = [];

  // SocketManager() : channel = IOWebSocketChannel.connect(_socketUrl) {
  //   isConnected = false;
  //   channel.stream.listen((data) {
  //     _handleMessage(data);
  //     log(data);
  //   });
  //   channel.sink.done.then((_) {
  //     isConnected = false;
  //     log("WebSocket connection closed.");
  //   });
  // }

  void sendData(String data) {
    channel.sink.add(data);
  }

  Stream<dynamic> get onMessage => channel.stream;

  void close() {
    channel.sink.close();
  }

  void addMessageListener(Function(dynamic) listener) {      
    _messageListeners.add(listener);
  }

  void removeMessageListener(Function(dynamic) listener) {
    _messageListeners.remove(listener);
  }

  void _handleMessage(dynamic data) {
    for (final listener in _messageListeners) {
      listener(data);
    }
  }

  void register(String userId) {
    var json = {"event": "register_socket", "userId": userId};
    channel.sink.add(jsonEncode(json));
  }
}
