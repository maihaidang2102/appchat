// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat/blocs/cubit_messages/messages_state.dart';
import 'package:chat/model/response_message.dart';

import '../../api_service/authentication.dart';
import '../../api_service/socket_manager.dart';

class MessageCubit extends Cubit<MessagesState> {
  MessageCubit() : super(MessageInitial()) {
    _socketManager.addMessageListener((data) async {
      try {
        final jsonData = jsonDecode(data);
        final event = jsonData['event'];
        if (event == 'list_message') {
          ResponseListMessage responseListMessage =
              ResponseListMessage.fromJson(data);
          updateMessages(responseListMessage.listMessage);
        }
        if (event == 'send_message') {
          final messageData = jsonData['message'];
          final responseMessage = MessageItem.fromMap(messageData);

          // print('Received message1: $messageData');
          // print('Received message2: $responseMessage');

          // Lấy trạng thái hiện tại của MessagesState
          final currentState = state;

          final prefs = await SharedPreferences.getInstance();
          final String? groupId = prefs.getString('groupId');

          if (currentState is MessagesLoaded &&
              responseMessage.groupId.id == groupId!) {
            log(responseMessage.toJson());

            final updatedMessages = [...currentState.messages, responseMessage];
            // print('Received message3: $updatedMessages');
            // Cập nhật danh sách tin nhắn và emit trạng thái mới
            emit(MessagesLoaded(updatedMessages));
          } else {
            print("");
            // Nếu currentState không phải là MessagesLoaded, bạn có thể xử lý nó theo cách bạn muốn.
          }
        }
      } catch (e) {
        log('Lỗi xử lý dữ liệu messsage cubit: $e');
      }
    });
  }
  final _socketManager = SocketManager.instance;

  Future<String?> checkGroupIDAndFetchUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString('userID');

    // if (groupID != null) {
    //   // Đã có groupID trong storage, trả về nó.
    //   log('groupID found in storage: $groupID');

    //   return groupID;
    // } else {
    // Không có groupID trong storage, gọi API để lấy chi tiết người dùng.
    final apiService = ApiServiceAuthentication();
    try {
      final userDetailResponse = await apiService.getUserDetail(userID!);
      final newGroupID = userDetailResponse.data!.id;

      // Kiểm tra nếu newGroupID không phải là null thì lưu và trả về nó.
      if (newGroupID!.isNotEmpty) {
        // Lưu newGroupID vào SharedPreferences.
        prefs.setString('groupId', newGroupID);

        log('Fetched and stored groupID: $newGroupID');

        // Trả về newGroupID sau khi lấy từ API.
        return newGroupID;
      } else {
        // Nếu newGroupID là rỗng, trả về null hoặc giá trị mặc định khác tùy theo yêu cầu.
        return null;
      }
    } catch (e) {
      log('Failed to fetch user detail: $e');
      // Trả về null trong trường hợp lỗi.
      return null;
    }
    // }
  }

  void createGroup() async {
    try {
      // Gọi hàm createGroup từ SocketManager
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('userID');
      final List<String> members = [userID ?? ''];

      _socketManager.createGroup(userID!, members);

      emit(
          GroupCreating()); // Emit một trạng thái để thông báo rằng đang tạo nhóm.
      emit(MessagesLoaded([]));
    } catch (e) {
      emit(MessageError("Failed to create group: $e"));
    }
  }

  void sendMessage(String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final groupID = prefs.getString('groupId');
      final userID = prefs.getString('userID');

      if (groupID != null && userID != null) {
        _socketManager.sendMessage(message);

        //emit(MessageSent()); // Emit một trạng thái để thông báo rằng tin nhắn đã được gửi.
      } else {
        emit(MessageError("Group ID or User ID is missing."));
      }
    } catch (e) {
      emit(MessageError("Failed to send message: $e"));
    }
  }

  void getListMessage(String groupId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('groupId', groupId);

      _socketManager.getListMessage(groupId);
    } catch (e) {
      emit(MessageError("Failed to get list of messages: $e"));
    }
  }

  void updateMessages(List<MessageItem> messages) {
    emit(MessagesLoaded(messages));
  }
}
