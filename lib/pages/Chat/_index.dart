import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('微信'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 执行搜索操作
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 显示更多操作菜单
            },
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 打开新会话页面
        },
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  final String avatar;
  final String title;
  final String message;
  final String time;
  final int unreadCount;

  ConversationItem({
    required this.avatar,
    required this.title,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatar),
      ),
      title: Text(title),
      subtitle: Text(message),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(time),
          if (unreadCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
    );
  }
}
