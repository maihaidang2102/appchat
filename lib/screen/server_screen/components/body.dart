// ignore_for_file: library_private_types_in_public_api

import 'package:chat/blocs/cubit_listgroup/list_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/message_detail.dart';
import '../../components/message_list.dart';

class BodyServer extends StatelessWidget {
  final List<String> conversations;

  const BodyServer({super.key, required this.conversations});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListGroupCubit(),
      child: Builder(
        builder: (context) {
          context.read<ListGroupCubit>().getListGroup();
          return Row(
            children: [
              // Phần bên trái - Danh sách người nhắn tin
               MessageList(
                //     onSelectConversation: (conversation) {
                //       // Xử lý khi một người nhắn tin được chọn
                //       setState(() {
                //         selectedConversation = conversation;
                //       });
                   
                // },
              ),
              // Phần bên phải - Tin nhắn chi tiết
              MessageDetail(selectedConversation: ''),
            ],
          );
        }
      ),
    );
  }
}
