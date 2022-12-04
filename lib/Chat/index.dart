import 'package:flutter/material.dart';
import 'package:freechat/Chat/SessionBox/index.dart';
import 'package:freechat/common/NavbarMoreList/index.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey iconAddkey = GlobalKey();
  late double iconAddOffsetX;
  late double iconAddOffsetY;
  late Size iconAddSize;
  late Function closeModel;

  final List<String> _chatUserList = <String>['王浩', '测试1', '测试2'];

  void _searchContent() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text('免聊'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search), onPressed: _searchContent),
            IconButton(
                key: iconAddkey,
                icon: const Icon(Icons.add),
                onPressed: () {
                  // 通过key获取到widget的位置
                  RenderObject addNode = iconAddkey.currentContext?.findRenderObject() as RenderObject;

                  // 获取widget的高宽
                  iconAddSize = addNode.paintBounds.size;

                  // 获取位置
                  final temp = addNode.getTransformTo(null).getTranslation();

                  iconAddOffsetX = temp.x;
                  iconAddOffsetY = temp.y;
                  
                  _moreActions(context);
                }),
          ],
        ),
        body: _buildChatList());
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return const Divider();
        }
        final int index = i ~/ 2;
        if (index >= _chatUserList.length) {
          _chatUserList.addAll(
              ['王浩', '测试1', '测试2', '王浩', '测试1', '测试2', '王浩', '测试1', '测试2']);
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
              )),
        );
      },
    );
  }

  void _moreActions(BuildContext context) {

    final left = iconAddOffsetX;
    final top = iconAddOffsetY + iconAddSize.height;

    Navigator.push(context,
      NavbarMoreList(
        left: left,
        top: top
      )
    );
  }
}
