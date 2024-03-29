import 'package:flutter/material.dart';
import 'package:freechat/pages/Index/index.dart';
import 'package:freechat/pages/Auth/login.dart';
import 'package:freechat/utils/sp_cache.dart';

import 'package:provider/provider.dart';
import 'package:freechat/Store/index_store.dart';

// 这里为入口函数
void main() => runApp(MultiProvider(
  providers: [ChangeNotifierProvider(create: (context) => IndexStore())],
  child: const App(),
));

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  bool isLogin = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  void initState() {
    super.initState();
    initCache();
  }

  void initCache() async {
    var cacheToken = await SpCache.getString('cache_token');
    setState(() => isLogin = cacheToken != null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(body: isLogin ? const Index() : const Login()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      )
    );
  }
}
