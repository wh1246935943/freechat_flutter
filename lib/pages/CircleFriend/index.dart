import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:jhtoast/jhtoast.dart';

class CircleFriend extends StatefulWidget {
  const CircleFriend({super.key});

  @override
  State<CircleFriend> createState() => _CircleFriendState();
}

class _CircleFriendState extends State<CircleFriend> {

  ScrollController _scrollController = ScrollController();

  double _imgNormalHeight = 300;
  double _imgExtraHeight = 0;
  double _imgChangeHeight = 0;
  double _scrollMinOffSet = 0;
  double _navH = 0;
  double _appbarOpacity = 0.0;

  @override
  void initState() {
    // _navH = JhScreenUtils.navigationBarHeight;
    _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navH;
    // _addListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1, centerTitle: true, title: const Text("朋友圈")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Text("正在编码")
          ],
        ),
      ),
    );
  }
}
