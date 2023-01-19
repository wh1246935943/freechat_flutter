import 'package:flutter/material.dart';
import '../common/dd_bottom_sheet.dart';
import '../common/dd_nine_picture.dart';
import './../../config/project_config.dart';
import './../../vo/wx_friends_circle_model.dart';

class WxFriendsCircleCell extends StatelessWidget {
  const WxFriendsCircleCell({
    Key? key,
    required this.model,
    this.onClickCell,
    this.onClickHeadPortrait,
    this.onClickComment,
  }) : super(key: key);

  final WxFriendsCircleModel model;
  final Function(dynamic model)? onClickCell;
  final Function(dynamic model)? onClickHeadPortrait;
  final Function(dynamic model)? onClickComment;

  @override
  Widget build(BuildContext context) {
    return _cell(context);
  }

  _cell(context) {
    return InkWell(
      onTap: () => onClickCell?.call(model.toJson()),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: KColors.kLineColor, width: 1),
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: KColors.dynamicColor(context, KColors.kLineColor, KColors.kLineDarkColor),
            ), // 下边框
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像
            InkWell(
              onTap: () => onClickHeadPortrait?.call(model.toJson()),
              child: Container(
                margin: const EdgeInsets.all(15),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: DDColorUtils.hexColor(model.color!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(model.name!.substring(0, 1), style: const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 13),
                    child: Text(
                      model.name!,
                      style: const TextStyle(color: KColors.wxTextBlueColor, fontSize: 15),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                      child: Text(model.content ?? '', style: const TextStyle(fontSize: 13))),
                  _imagesWidget(context),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 15, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.time ?? '',
                          style: const TextStyle(color: KColors.kLightGreyTextColor, fontSize: 13),
                        ),
                        InkWell(
                          child: Container(
                            width: 34,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: KColors.dynamicColor(
                                  context, const Color.fromRGBO(240, 240, 240, 1), KColors.kCellBgDarkColor),
                            ),
                            child: Image.asset(
                              'lib/assets/ic_diandian.png',
                              color: KColors.wxTextBlueColor,
                            ),
                          ),
                          onTap: () => onClickComment?.call(model.toJson()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 图片view
  Widget _imagesWidget(context) {
    return DDNinePicture(
      imgData: model.images ?? [],
      lRSpace: (80.0 + 20.0),
      onLongPress: () {
        print('onLongPress:');
        DDBottomSheet.showText(context, dataArr: ['保存图片']);
      },
    );
  }
}
