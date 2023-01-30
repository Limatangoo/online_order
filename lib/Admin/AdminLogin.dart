import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Login"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text("hello world"),
              ElevatedButton(onPressed: (){print('ok');}, child: const Text("press me"))
            ],
          ),
        ),
      ),
    );
  }
}