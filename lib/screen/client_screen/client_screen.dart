import 'package:chat/screen/components/message_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cubit_messages/messages_cubit.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Khách hàng',
          textScaleFactor: 1,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Row(
        children: [
          BlocProvider(
            create: (context) => MessageCubit(), // Tạo một instance của MessageCubit
            child: const MessageDetail(),
          ),
        ],
      ),
    );
  }
}
