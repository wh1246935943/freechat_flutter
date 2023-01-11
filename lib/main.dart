import 'package:flutter/material.dart';
import 'package:freechat/pages/Index/index.dart';
import 'package:freechat/pages/Auth/login.dart';

import 'package:provider/provider.dart';
import 'package:freechat/Store/IndexStore.dart';

// 这里为入口函数
void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(
    create: (context) => IndexStore())
  ],
    child: const App(),
  )
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    bool isLogin = Provider.of<IndexStore>(context).loginState;

    return MaterialApp(
      home: Scaffold(
        body: isLogin ? const Index() : const Index()
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // 设置主题颜色
      )
    );
  }
}

