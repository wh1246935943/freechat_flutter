import 'package:flutter/material.dart';
import 'package:freechat/pages/Auth/login.dart';
import 'package:freechat/utils/dd_toast.dart';
import 'package:path/path.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}


class _MyState extends State<My> {

  final List<String> funs = <String>['收藏', '朋友圈', '视频号', '设置'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('我')
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://img0.baidu.com/it/u=2900833435,993445529&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("豆豆", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text("免聊号: ${"我是豆豆"}", style: TextStyle(color: Color.fromARGB(255, 128, 128, 128), fontSize: 14, fontWeight: FontWeight.w600)),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _buildFunsList()
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: _buildLoginout(context)
            )
          ]
        )
      )
    );
  }

  Widget _buildFunsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: funs.length,
      itemBuilder: (BuildContext context, int index) {
        String name = funs[index];
        return (
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Image(
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      image: NetworkImage('https://img0.baidu.com/it/u=2900833435,993445529&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500'),
                    ),
            title: Text(name),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              DDToast.info(name);
            },
          )
        );
      }
    );
  }

  Widget _buildLoginout(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 270,
      child: ElevatedButton(
        style: ButtonStyle(
            // 设置圆角
            shape: MaterialStateProperty.all(const StadiumBorder(
                side: BorderSide(style: BorderStyle.none)))),
        child: Text('退出登录',
            style: Theme.of(context).primaryTextTheme.headline5),
        onPressed: () {
          _loginout(context);
          
        }
      )
    );
  }

  void _loginout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("确定退出吗？"),
          actions: [
            TextButton(
              onPressed: () {
                DDToast.warn('取消了');
                Navigator.of(context).pop();
              },
              child: const Text("取消"),
            ),
            TextButton(
              onPressed: () {
                // 表单校验通过才会继续执行
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(builder: (context) => const Login())
                );
              },
              child: const Text("确定")
            )
          ],
        );
      },
    );
  }
}