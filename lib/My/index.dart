import 'package:flutter/material.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}


class _MyState extends State<My> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('我')
      ),
      body: const Text('我的信息页面')
    );
  }
}