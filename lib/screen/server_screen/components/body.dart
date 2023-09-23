// ignore_for_file: library_private_types_in_public_api

import 'package:chat/blocs/cubit_listgroup/list_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/message_detail.dart';
import '../../components/message_list.dart';

class BodyServer extends StatefulWidget {
  const BodyServer({super.key});

  @override
  State<BodyServer> createState() => _BodyServerState();
}

class _BodyServerState extends State<BodyServer> {

  @override
  Widget build(BuildContext context) {
    context.read<ListGroupCubit>().getListGroup();

    return const Row(
      children: [
        // Phần bên trái - Danh sách người nhắn tin
        MessageList(),
        // Phần bên phải - Tin nhắn chi tiết
        MessageDetail(),
      ],
    );
  }
}
