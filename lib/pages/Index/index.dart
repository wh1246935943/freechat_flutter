import 'package:flutter/material.dart';
import 'package:freechat/pages/Chat/index.dart';
import 'package:freechat/pages/My/index.dart';
import 'package:freechat/pages/Find/index.dart';
import 'package:freechat/pages/Contacts/index.dart';
import 'navigation_icon_view.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<StatefulWidget> createState() => _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {

  int currentIndex = 0;
  late final List<NavigationIconView> navigationViews = <NavigationIconView>[
    NavigationIconView(icon: const Icon(Icons.chat), title: '免聊', vsync: this),
    NavigationIconView(icon: const Icon(Icons.contact_mail), title: '联系人', vsync: this),
    NavigationIconView(icon: const Icon(Icons.auto_awesome_sharp), title: '发现', vsync: this),
    NavigationIconView(icon: const Icon(Icons.account_circle), title: '我的', vsync: this),
  ];
  final List<Widget> pageList = const <Widget>[
    Chat( key: PageStorageKey<String>('Chat') ),
    Contacts( key: PageStorageKey<String>('Contacts') ),
    Find( key: PageStorageKey<String>('Find') ),
    My( key: PageStorageKey<String>('My') )
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {

    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.black,
      items: navigationViews
        .map((NavigationIconView navigationIconView) => navigationIconView.item)
        .toList(), // 添加 icon 按钮
      currentIndex: currentIndex, // 当前点击的索引值
      type: BottomNavigationBarType.fixed, // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index){ // 添加点击事件
        setState((){ // 点击之后，需要触发的逻辑事件
          navigationViews[currentIndex].controller.reverse();
          currentIndex = index;
          navigationViews[currentIndex].controller.forward();
        });
      },
    );

    return MaterialApp(
      home: Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: pageList[currentIndex],
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
      theme: ThemeData(
        primarySwatch: Colors.green, // 设置主题颜色
      )
    );
  }
}