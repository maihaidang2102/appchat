// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:chat/blocs/bloc_message/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/socket_manager.dart';
import '../../blocs/cubit_login/login_cubit.dart';
import '../../blocs/cubit_messages/messages_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/cubit_messages/messages_state.dart';


class MessageDetail extends StatefulWidget {
  final String selectedConversation;

  const MessageDetail({super.key, required this.selectedConversation});

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  late final TextEditingController _controller;
  @override
  // Future<void> initState() async {
  //   _controller = TextEditingController();
  //   super.initState();
  //   final prefs = await SharedPreferences.getInstance();
  //   int? role = prefs.getInt('userRole');
  //   if(role == 1){
  //     _fetchAndPrintGroupID();
  //   }
  // }
  void initState() {
    _controller = TextEditingController();
    super.initState();
    _fetchAndPrintGroupID();
  }

  void _fetchAndPrintGroupID() async {
    final messageCubit = context.read<MessageCubit>();
    final prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt('userRole');
    if (role == 1) {
      final groupID = await messageCubit.checkGroupIDAndFetchUserDetail();
      if (groupID != '1') {
        print('Group ID: $groupID');
        _getListMessageSocket(groupID!);
      } else {
        print('Failed to fetch Group ID.');
        _createGroupSocket();
      }
    } else if (role == 0) {
      if(widget.selectedConversation != ''){
        _getListMessageSocket(widget.selectedConversation);
      }
    }
  }

  void _getListMessageSocket(String groupId) {
    final messageCubit = context.read<MessageCubit>();
    messageCubit.getListMessage(groupId);
  }

  void _createGroupSocket() {
    final messageCubit = context.read<MessageCubit>();
    messageCubit.createGroup();
  }
  void _sendMessage(BuildContext context) {
    //final messageCubit = BlocProvider.of<MessageCubit>(context);
    //final messageCubitt = MessageCubit();
    final messageCubit = context.read<MessageCubit>();
    final messageText = _controller.text.trim();

    if (messageText.isNotEmpty) {
      messageCubit.sendMessage(messageText);
      _controller.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(width: 1, color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Đang trò chuyện với: ${widget.selectedConversation}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<MessageCubit, MessagesState>(
                    builder: (context, state) {
                      if (state is MessagesLoaded) {
                        final messages = state.messages;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return MessageBubble(
                              content: message.message,
                              senderID: message.id,
                            );
                          },
                        );
                      } else {
                        // Hiển thị một tiêu đề hoặc thông báo tùy ý khi không có tin nhắn hoặc lỗi.
                        return Center(
                          child: Text('Không có tin nhắn hoặc có lỗi xảy ra.'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.enter) {
                  _sendMessage(context);
                }
              },
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black12),
                    right: BorderSide(width: 1, color: Colors.black12),
                    left: BorderSide(width: 1, color: Colors.black12),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _controller,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  onSubmitted: (value) => _sendMessage(context),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Nhập tin nhắn'),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              splashColor: Colors.grey.shade200,
              hoverColor: Colors.grey.shade200,
              onTap: () => _sendMessage(context),
              child: Container(
                height: 50.0,
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Text(
                  "Gửi",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final String time;
  final String senderID;

  Message({
    required this.content,
    required this.time,
    required this.senderID,
  });
}

class MessageBubble extends StatelessWidget {
  final String content;
  final String senderID;

  const MessageBubble(
      {super.key, required this.content, required this.senderID});

  @override
  Widget build(BuildContext context) {
    final Color? bubbleColor =
    senderID == 'Client' ? Colors.grey.shade400 : Colors.grey[200];

    final CrossAxisAlignment alignment = senderID == 'Client'
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            'Thời gian: ${DateTime.now().toString()}',
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
