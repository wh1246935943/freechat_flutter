import 'package:flutter/material.dart';
import 'package:freechat/Chat/index.dart';
import 'package:freechat/My/index.dart';
import 'package:freechat/Find/index.dart';
import 'package:freechat/Contacts/index.dart';
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

  List<StatefulWidget> pageList = <StatefulWidget>[
    const Chat(),
    const Contacts(),
    const Find(),
    const My(),
  ];

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
        body: Center(
          child: pageList.elementAt(currentIndex),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
      theme: ThemeData(
        primarySwatch: Colors.green, // 设置主题颜色
      )
    );
  }
}