import 'package:flutter/material.dart';
import 'package:freechat/Chat/SessionBox/index.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}


class _ChatState extends State<Chat> {

  final List<String> _chatUserList = <String>['王浩', '测试1', '测试2'];

  void _moreActions() {
  }

  void _searchContent() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('免聊'),
        actions: <Widget>[      // 新增代码开始 ...
          IconButton(icon: const Icon(Icons.search), onPressed: _searchContent),
          IconButton(icon: const Icon(Icons.add), onPressed: _moreActions),
        ], 
      ),
      body: _buildChatList()
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return const Divider();
        }
        final int index = i ~/ 2;
        if (index >= _chatUserList.length) {
          _chatUserList.addAll(['王浩', '测试1', '测试2', '王浩', '测试1', '测试2', '王浩', '测试1', '测试2']);
        }
        return _buildRow(_chatUserList[index]);
      }
    );
  }

  Widget _buildRow(String name) {
    return ListTile(
      title: Text(name),
      trailing: const Text('23:10'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const SessionBox(),
            settings: RouteSettings(
              name: name,
            )
          ),
        );
      },
    );
  }
}