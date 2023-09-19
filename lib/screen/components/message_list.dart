import 'package:chat/blocs/cubit_listgroup/list_group_cubit.dart';
import 'package:chat/model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageList extends StatefulWidget {
  // final List<GroupModel> listGroup;
  // final Function(GroupModel) onSelectConversation;

  const MessageList({
    super.key,
    // required this.listGroup,
    // required this.onSelectConversation,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  int _seleted = 0;
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
                color: _seleted == index ? Colors.grey.shade300 : null,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.members.last.userName.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                       model.lastMessage?.message.toString() ?? "",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      _seleted = index;
                    });
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
