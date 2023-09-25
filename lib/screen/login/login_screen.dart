import 'package:chat/blocs/cubit_login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat/screen/client_screen/client_screen.dart';
import 'package:chat/screen/server_screen/server_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isNameEntered = false; // Biến để kiểm tra xem tên đã được nhập hay chưa

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loggedIn && state.registeredSocket) {
          if (state.role == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ServerScreen()),
            );
          } else if (state.role == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ClientScreen()),
            );
          } else {}
        }
      },
      child: Builder(builder: (context) {
        context.read<LoginCubit>().checkAndNavigate();
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Đăng nhập',
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 500,
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Nhập tên:',
                      border:
                      OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    ),
                    onChanged: (value) {
                      // Kiểm tra xem người dùng đã nhập tên hay chưa
                      setState(() {
                        isNameEntered = value.isNotEmpty;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(Colors.grey.shade200),
                    overlayColor: const MaterialStatePropertyAll(Colors.grey),
                  ),
                  onPressed: () {
                    if (isNameEntered) {
                      // Chỉ gọi registerUser() nếu tên đã được nhập
                      context.read<LoginCubit>().registerUser(_controller.text);
                    } else {
                      // Hiển thị thông báo yêu cầu nhập tên
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng nhập tên trước khi bắt đầu.'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Bắt đầu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
