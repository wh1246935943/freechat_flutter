import 'package:flutter/material.dart';
import 'package:freechat/pages/common/dd_image/dd_image.dart';
import 'package:freechat/pages/Chat/SessionBox/index.dart';
import 'package:freechat/pages/common/NavbarMoreList/index.dart';

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

  void _searchContent() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('免聊'),
        centerTitle: true,
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
            }
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 20, // 假设有20个会话
        itemBuilder: (BuildContext context, int index) {
          return ConversationItem(
            avatar: 'assets/images/avatar_$index.jpg', // 假设有20张头像图片
            title: '联系人 $index',
            message: '最近的聊天记录',
            time: '下午1:23',
            unreadCount: index % 3, // 假设未读消息数量为0~2之间的随机数
          );
        }
      )
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

class ConversationItem extends StatelessWidget {
  final String avatar;
  final String title;
  final String message;
  final String time;
  final int unreadCount;

  const ConversationItem({
    super.key, 
    required this.avatar,
    required this.title,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const DDImage(
        url:'http://freechat.bilinstore.com/files/avatar/6ab4b259-2838-4620-ad73-a3e74539ffb01674267717151.png',
        width: 40,
        height: 40,
      ),
      title: Text(title),
      subtitle: Text(message),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(time),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const SessionBox(),
            settings: RouteSettings(
              name: title,
            )
          )
        );
      },
    );
  }
}
