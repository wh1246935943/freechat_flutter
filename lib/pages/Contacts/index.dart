import 'package:flutter/material.dart';
import 'package:freechat/pages/common/dd_image/dd_image.dart';
import 'package:freechat/utils/dd_toast.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});
  @override
  State createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<String> _letters = [    '#',    'A',    'B',    'C',    'D',    'E',    'F',    'G',    'H',    'I',    'J',    'K',    'L',    'M',    'N',    'O',    'P',    'Q',    'R',    'S',    'T',    'U',    'V',    'W',    'X',    'Y',    'Z',  ];

  List<String> _contacts = [    '张三',    '李四',    '王五',    '赵六',    '韩七',    '郑八',    '孙九',    '周十',    '吴十一',    '郭十二',    '陈十三',    '刘十四',    '林十五',    '徐十六',    '何十七',    '马十八',    '胡十九',    '王二十',    '孙二十一',    '谢二十二',    '黄二十三',    '朱二十四',    '董二十五',    '范二十六',    '宋二十七',    '郎二十八',    '钱二十九',    '吕三十',  ];

  final List<List<String>> funs = [
    ["新的朋友", 'lib/assets/ic_social_circle.png'],
    ["仅聊天的朋友", 'lib/assets/ic_collections.png'],
    ["群聊", 'lib/assets/ic_bottle_msg.png'],
    ["标签", 'lib/assets/ic_settings.png'],
    ["公众号", 'lib/assets/ic_settings.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通讯录'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFunsList(),
          Expanded(
            child: Container(
              height: 15,
              color: Colors.grey[300],
              child: const Text(
                '我的企业及联系人',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                )
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _letters.length + _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < _letters.length) {
                  return Container(
                    height: 30,
                    color: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(_letters[index]),
                  );
                } else {
                  final contact = _contacts[index - _letters.length];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(contact[0]),
                    ),
                    title: Text(contact),
                  );
                }
              },
            ),
          ),
        ],
      )
    );
  }

  Widget _buildFunsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: funs.length,
      itemBuilder: (BuildContext context, int index) {
        String name = funs[index][0];
        String iconPath = funs[index][1];
        return (
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              children: [
                DDImage(
                  isNet: false,
                  url: iconPath,
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(name),
                )
              ]
            )
          )
        );
      }
    );
  }
}
