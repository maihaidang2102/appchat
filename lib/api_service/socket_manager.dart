// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketManager {
  // static const String _socketUrl = "ws://3469-171-226-133-187.ngrok-free.app/vps-chat/ws";
  static const String _socketUrl = "ws://13.214.193.32/vps-chat/ws";

  SocketManager._internal() {
    isConnected = true;
    channel.stream.listen((data) {
      _handleMessage(data);
      addMessageListener(_handleCreateGroup);
      // log(data);
    });
    channel.sink.done.then((_) {
      isConnected = false;
      log("WebSocket connection closed.");
    });
  }
  static final SocketManager _instance = SocketManager._internal();

  static SocketManager get instance => _instance;

  final WebSocketChannel channel = IOWebSocketChannel.connect(_socketUrl);
  late bool isConnected; // Thêm một biến để theo dõi trạng thái kết nối.
  final List<Function(dynamic)> _messageListeners = [];

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

  Future<void> _handleCreateGroup(dynamic data) async {
    try {
      if (data.contains("event")) {
        final jsonData = jsonDecode(data);
        final event = jsonData['event'];

        if (event == 'created_group') {
          final newGroup = jsonData['newGroup'];
          final groupId = newGroup['_id'];
          final response = jsonData['newGroup'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('groupID', groupId);

          // Xử lý dữ liệu trả về từ sự kiện create_group ở đây
          // Ví dụ: In ra thông báo
          log('Sự kiện create_group được trả về: $response');
        }
      }
    } catch (e) {
      log('Lỗi xử lý dữ liệu handle create Group: $e');
    }
  }

  void register(String userId) {
    var json = {"event": "register_socket", "userId": userId};
    channel.sink.add(jsonEncode(json));
  }

  Future<void> createGroup(String ownerUin, List<String> members) async {
    final newGroup = {
      "groupType": 0,
      "members": members,
      "ownerUin": ownerUin,
    };

    final eventData = {
      "event": "create_group",
      "newGroup": newGroup,
    };

    sendData(jsonEncode(eventData));
  }

  Future<void> sendMessage(String message) async {
    const messageType = 1;
    const status = 0;
    final prefs = await SharedPreferences.getInstance();
    final groupID = prefs.getString('groupID');
    final userID = prefs.getString('userID');

    final messageData = {
      "event": "send_message",
      "message": {
        "type": messageType,
        "status": status,
        "groupId": groupID,
        "message": message,
        "senderInfo": userID,
      }
    };

    sendData(jsonEncode(messageData));
  }

  Future<void> getListMessage(String groupId) async {
    final messageData = {"event": "list_message", "groupId": groupId};
    sendData(jsonEncode(messageData));
  }

  // void _handleListMessage(dynamic data) {
  //   try {
  //     if (data.contains('evet')) {
  //       final jsonData = jsonDecode(data);
  //       final event = jsonData['event'];

  //       if (event == 'list_message') {
  //         // Gọi Cubit để cập nhật danh sách tin nhắn (hoặc thực hiện các tác vụ cần thiết)
  //         // Ví dụ: ListGroupCubit.instance.updateMessages(jsonData['messages']);
  //       }
  //     }
  //   } catch (e) {
  //     log('Lỗi xử lý dữ liệu handle List Mess: $e');
  //   }
  // }
}
