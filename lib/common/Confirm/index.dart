import 'package:flutter/material.dart';
import 'package:freechat/common/NavbarMoreList/content_box.dart';

class NavbarMoreList<T> extends PopupRoute<T> {
  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(seconds: 0);

  /// backgroudView Color
  final Color? backgroudViewColor;
  /// child'alignment, default value: [Alignment.center]
  final Alignment alignment;

  NavbarMoreList({this.backgroudViewColor, this.alignment = Alignment.center});

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              color: backgroudViewColor ?? Colors.black.withOpacity(0.3),
            ),
            SafeArea(
              child: Align(
                alignment: alignment,
                child: ContentBox(
                  marginHor: 10,
                  title: const Text('123', style: TextStyle(fontWeight: FontWeight.w500),),
                  content: const Text('456', style: TextStyle(fontWeight: FontWeight.w300),),
                  actionCancell: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("取消"),
                  ),
                  actionConfirm: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("确定"),
                  )
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          // onClick();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}