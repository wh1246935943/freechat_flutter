import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {

  final Widget? title;
  final Widget? content;

  final double marginHor;
  final List<Widget>? actions;
  final Widget? actionCancell;
  final Widget? actionConfirm;

  const ContentBox({
    Key? key,
    this.title,
    this.content,
    this.marginHor = 15,
    this.actions,
    this.actionCancell,
    this.actionConfirm,
  }) :  assert((title != null || content != null)),
        assert(marginHor >= 0),
        assert((actions != null || actionCancell != null || actionConfirm != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double spacingVer = 8;
    double spacingHor = 15;

    return Container(
      width: screenSize.width - marginHor*2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((5.0)), // 圆角度
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) Padding(
            padding: EdgeInsets.only(top: spacingVer, left: spacingHor, bottom: spacingVer, right: spacingHor),
            child: title,
          ),
          if (title != null) Padding(
            padding: EdgeInsets.only(left: spacingHor, bottom: spacingVer, right: spacingHor),
            child: content,
          ),
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions != null ? actions!.map((e) => Expanded(child: e,),).toList()
                :
            [
              if (actionCancell != null) Expanded(child: actionCancell!,),
              SizedBox(height: 55, child: VerticalDivider(color: Colors.grey[400])),
              if (actionConfirm != null) Expanded(child: actionConfirm!,),
            ],
          ),
        ],
      ),
    );
  }
}