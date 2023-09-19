import 'dart:developer';

import 'package:chat/blocs/bloc_message/message_bloc.dart';
import 'package:flutter/material.dart';

import 'package:chat/screen/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("===================== BEGIN =======================");
    return BlocProvider(
      create: (context) => MessageBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey, primary: Colors.grey),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
