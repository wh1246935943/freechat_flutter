import 'package:flutter/material.dart';
import 'package:freechat/pages/Chat/GroupSessionBox/index.dart';

class ContentBox extends StatelessWidget {

  final double top;
  final double left;
  final Function close;
  List? data = [1, 2, 3, 4];

  double popupWidth = 180;

  List list = ["发起群聊", "添加朋友", "扫一扫", "收付款"];

  ContentBox({
    Key? key,
    required this.top,
    required this.left,
    required this.close,
    this.data
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left - (popupWidth / 2) - 50,
      top: top,
      child: Container(
        width: popupWidth,
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(76, 76, 76, 1),
          borderRadius: BorderRadius.circular((5.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list.map<Widget>((e) => InkWell(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            onTap: () {
              close();
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const GroupSessionBox(),
                  settings: RouteSettings(
                    name: e,
                  )
                ),
              );
            },
          )).toList(),
        )
      )
    );
  }
}