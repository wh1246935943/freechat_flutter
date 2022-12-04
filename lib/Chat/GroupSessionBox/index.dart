import 'package:flutter/material.dart';

class GroupSessionBox extends StatefulWidget {
  const GroupSessionBox({super.key});

  @override
  State<GroupSessionBox> createState() => _GroupSessionBoxState();
}


class _GroupSessionBoxState extends State<GroupSessionBox> {

  @override
  Widget build(BuildContext context) {

    String? name = ModalRoute.of(context)?.settings.name;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(name!)
      ),
      body: const Text('这里展示群聊天的内容')
    );
  }
}