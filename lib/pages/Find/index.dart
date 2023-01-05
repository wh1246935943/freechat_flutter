import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  const Find({super.key});

  @override
  State<Find> createState() => _FindState();
}


class _FindState extends State<Find> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('发现')
      ),
      body: const Text('发现页面')
    );
  }
}