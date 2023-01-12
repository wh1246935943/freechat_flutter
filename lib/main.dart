import 'package:flutter/material.dart';
import 'package:freechat/pages/Index/index.dart';
import 'package:freechat/pages/Auth/login.dart';
import 'package:freechat/utils/sp_cache.dart';

import 'package:provider/provider.dart';
import 'package:freechat/Store/IndexStore.dart';

// 这里为入口函数
void main() => runApp(MultiProvider(
  providers: [ChangeNotifierProvider(create: (context) => IndexStore())],
  child: App(),
));

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  bool isLogin = false;

  // @protected
  // @factory
  // State<> createState() {
  //   initCache();
  // }

  // @override
  // State<App> createState() {
  //   initCache();
  // }

  @override
  void initState() {
    print('________kaishi__________');

    initCache();

    super.initState();
  }

  void initCache() async {
    bool isOpenCache = await SpCache.init();
    if (isOpenCache) {
      var userName = await SpCache.getString('cache_token');
      setState(() => isLogin = userName != '');
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isLogin = Provider.of<IndexStore>(context).loginState;
    return MaterialApp(
      home: Scaffold(body: isLogin ? const Index() : const Login()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      )
    );
  }
}
