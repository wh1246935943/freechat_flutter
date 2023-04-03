import 'package:flutter/material.dart';
import 'package:freechat/utils/sp_cache.dart';
import 'package:freechat/vo/user_info_vo.dart';

class SessionBox extends StatefulWidget {
  const SessionBox({Key? key}) : super(key: key);
  @override
  State<SessionBox> createState() => _SessionBoxState();
}

class _SessionBoxState extends State<SessionBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Message> _messages = [];

  UserInfoVo _userInfoVo = UserInfoVo();

  final ScrollController _scrollController = ScrollController();
  // double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToBottom();
    //   _scrollOffset = _scrollController.position.maxScrollExtent;
    // });
  }

  void getUserInfo() async {
    var respString = SpCache.getObject('user_info_vo');
    setState(() => _userInfoVo = UserInfoVo.fromJson(respString));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 72,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    String? name = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(name!),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: '请输入',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                FloatingActionButton(
                  onPressed: () {
                    final text = _textEditingController.text;
                    if (text.isNotEmpty) {
                      final message = Message(
                        text: text,
                        isMe: true,
                        avatarUrl: _userInfoVo.avatar ?? '',
                        name: _userInfoVo.nickName ?? '',
                      );
                      setState(() {
                        _messages.insert(_messages.length, message);
                        _textEditingController.clear();
                      });
                      _scrollToBottom();
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;
  final String name;
  final String avatarUrl;

  Message({
    required this.text,
    required this.isMe,
    this.name = '',
    this.avatarUrl = '',
  });
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isMe) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(message.avatarUrl),
            ),
            const SizedBox(width: 16.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 16.0),
            CircleAvatar(
              backgroundImage: NetworkImage(message.avatarUrl),
            ),
          ],
        ],
      ),
    );
  }
}
