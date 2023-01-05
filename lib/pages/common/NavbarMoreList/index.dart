import 'package:flutter/material.dart';
import 'content_box.dart';

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

  final double top;
  final double left;
  List? data;

  NavbarMoreList({
    this.backgroudViewColor,
    this.alignment = Alignment.center,
    this.data,
    required this.top,
    required this.left
  });

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
              color: backgroudViewColor ?? Colors.black.withOpacity(0),
            ),
            ContentBox(
              left: left,
              top: top,
              data: data,
              close: () {
                Navigator.of(context).pop();
              }
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}