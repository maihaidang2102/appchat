import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat/blocs/cubit_listgroup/list_group_cubit.dart';
import 'package:chat/blocs/cubit_messages/messages_cubit.dart';
import 'package:chat/model/group_model.dart';

class MessageList extends StatefulWidget {
  const MessageList({
    super.key,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  String _seleted = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListGroupCubit, ListGroupState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black12)),
          width: 200,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.listGroup.length,
              itemBuilder: (context, index) {
                GroupModel model = state.listGroup[index];
                return Container(
                  color: _seleted == model.id ? Colors.grey.shade300 : null,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.members.first.userName.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          model.lastMessage!.message ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _seleted = model.id ?? '';
                        context.read<MessageCubit>().getListMessage(model.id!);
                      });
                    },
                  ),
                );
              }),
        );
      },
    );
  }
}
