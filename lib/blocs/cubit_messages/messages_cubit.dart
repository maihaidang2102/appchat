import 'dart:convert';
import 'dart:developer';

import 'package:chat/blocs/cubit_messages/messages_state.dart';
import 'package:chat/model/response_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/authentication.dart';
import '../../api_service/socket_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCubit extends Cubit<MessagesState> {
  MessageCubit() : super(MessageInitial()) {
    final _socketManager = SocketManager.instance;

    _socketManager.addMessageListener((data) {
      try {
        final jsonData = jsonDecode(data);
        final event = jsonData['event'];

        if (event == 'list_message') {
            ResponseListMessage responseListMessage = ResponseListMessage.fromJson(data);
            print(data.toString());
            updateMessages(responseListMessage.listMessage);
        }
      } catch (e) {
        print('Lỗi xử lý dữ liệu: $e');
      }
    });

  }

  Future<String?> checkGroupIDAndFetchUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final groupID = prefs.getString('groupID');
    final userID = prefs.getString('userID');

    if (groupID != null) {
      // Đã có groupID trong storage, trả về nó.
      log('groupID found in storage: $groupID');
      return groupID;
    } else {
      // Không có groupID trong storage, gọi API để lấy chi tiết người dùng.
      final apiService = ApiServiceAuthentication();
      try {
        final userDetailResponse = await apiService.getUserDetail(userID!);
        final newGroupID = userDetailResponse.data?.id ?? '';

        // Kiểm tra nếu newGroupID không phải là null thì lưu và trả về nó.
        if (newGroupID.isNotEmpty) {
          // Lưu newGroupID vào SharedPreferences.
          prefs.setString('groupID', newGroupID);

          log('Fetched and stored groupID: $newGroupID');

          // Trả về newGroupID sau khi lấy từ API.
          return newGroupID;
        } else {
          // Nếu newGroupID là rỗng, trả về null hoặc giá trị mặc định khác tùy theo yêu cầu.
          return '1';
        }
      } catch (e) {
        log('Failed to fetch user detail: $e');
        // Trả về null trong trường hợp lỗi.
        return '1';
      }
    }
  }

  void createGroup() async {
    try {
      // Gọi hàm createGroup từ SocketManager
      final _socketManager = SocketManager.instance;
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('userID');
      final List<String> members = [userID ?? ''];

      _socketManager.createGroup(userID!, members);

      emit(GroupCreating()); // Emit một trạng thái để thông báo rằng đang tạo nhóm.
    } catch (e) {
      emit(MessageError("Failed to create group: $e"));
    }
  }

  void sendMessage(String message) async {
    try {
      final _socketManager = SocketManager.instance;
      final prefs = await SharedPreferences.getInstance();
      final groupID = prefs.getString('groupID');
      final userID = prefs.getString('userID');

      if (groupID != null && userID != null) {
        _socketManager.sendMessage(message);

        emit(MessageSent()); // Emit một trạng thái để thông báo rằng tin nhắn đã được gửi.
      } else {
        emit(MessageError("Group ID or User ID is missing."));
      }
    } catch (e) {
      emit(MessageError("Failed to send message: $e"));
    }
  }

  void getListMessage(String groupId) async {
    try {
      final _socketManager = SocketManager.instance;
      _socketManager.getListMessage(groupId);
    } catch (e) {
      emit(MessageError("Failed to get list of messages: $e"));
    }
  }

  void updateMessages(List<MessageItem> messages) {
    print("111111111111111111111");
    print(messages);
    print("111111111111111111111");
    emit(MessagesLoaded(messages));
  }
}
