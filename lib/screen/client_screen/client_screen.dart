import 'package:flutter/material.dart';


class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client'),
      ),
      body: Center(
        child: Text('Màn hình của Client '),
      ),
    );
  }
}
