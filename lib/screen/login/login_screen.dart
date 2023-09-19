// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          print(state.registeredSocket);
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
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                      ),
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
                    onPressed: () => context.read<LoginCubit>().registerUser(),
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
      ),
    );
  }
}
