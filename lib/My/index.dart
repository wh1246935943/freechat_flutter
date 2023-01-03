import 'package:flutter/material.dart';
import 'package:freechat/Auth/login.dart';

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
      body: Align(
        child: SizedBox(
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
              // 表单校验通过才会继续执行
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(builder: (context) => const Login())
              );
            }
          )
        )
      )
    );
  }
}