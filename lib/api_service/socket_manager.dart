import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class SocketManager {
  static const String _socketUrl = "ws://13.214.193.32:3000/vps-chat/ws";

  final WebSocketChannel channel;
  late bool isConnected; // Thêm một biến để theo dõi trạng thái kết nối.
  final List<Function(dynamic)> _messageListeners = [];

  SocketManager() : channel = IOWebSocketChannel.connect(_socketUrl) {
    isConnected = false;
    channel.stream.listen((data) {
      _handleMessage(data);
    });
    channel.sink.done.then((_) {
      isConnected = false;
      print("WebSocket connection closed.");
    });
  }

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
}
