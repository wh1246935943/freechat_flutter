import 'package:flutter/material.dart';

class SessionBox extends StatefulWidget {
  const SessionBox({super.key});

  @override
  State<SessionBox> createState() => _SessionBoxState();
}


class _SessionBoxState extends State<SessionBox> {

  @override
  Widget build(BuildContext context) {

    String? name = ModalRoute.of(context)?.settings.name;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(name!)
      ),
      body: const Text('这里展示我聊天的内容')
    );
  }
}