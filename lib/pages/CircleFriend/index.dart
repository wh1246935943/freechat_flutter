import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freechat/pages/common/dd_image/dd_image.dart';
import 'package:freechat/vo/user_info_vo.dart';
import '../../utils/sp_cache.dart';
import './../../config/project_config.dart';
import 'circle_friends_cell.dart';
import './../../vo/wx_friends_circle_model.dart';
import './../common/dd_bottom_sheet.dart';

class CircleFriend extends StatefulWidget {
  const CircleFriend({super.key});

  @override
  State<CircleFriend> createState() => _CircleFriendState();
}

class _CircleFriendState extends State<CircleFriend> {

  final ScrollController _scrollController = ScrollController();

  final double _imgNormalHeight = 300;
  double _imgExtraHeight = 0;
  double _imgChangeHeight = 0;
  double _scrollMinOffSet = 0;
  double _navH = 0;
  double _appbarOpacity = 0.0;
  UserInfoVo _userInfoVo = UserInfoVo();

  var _dataArr = [];

  @override
  void initState() {
    _navH = DDScreenUtils.navigationBarHeight;
    _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
    _scrollMinOffSet = _imgNormalHeight - _navH;
    _loadData();
    _addListener();
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    var respString = SpCache.getObject('user_info_vo');
    setState(() => _userInfoVo = UserInfoVo.fromJson(respString));
  }

  void _loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr = await rootBundle.loadString('lib/assets/json/circle_friends.json');

    Map dic = json.decode(jsonStr);
    List dataArr = dic['data'];
    _dataArr = dataArr;
    setState(() {});
  }

  _clickNav() {
    DDBottomSheet.showText(context, title: '请选择操作', dataArr: ['拍摄', '从手机相册选择'], clickCallback: (index, text) {});
  }

  // 滚动监听
  void _addListener() {
    _scrollController.addListener(() {
      double y = _scrollController.offset;
      // print('滑动距离: $y');

      if (y < _scrollMinOffSet) {
        _imgExtraHeight = -y;
//        print(_topH);
        setState(() {
          _imgChangeHeight = _imgNormalHeight + _imgExtraHeight;
        });
      } else {
        setState(() {
          _imgChangeHeight = _navH;
        });
      }
      // // 小于0 ，下拉放大
      // if (y < 0) {
      // } else {}

      // appbar 透明度
      double appBarOpacity = y / _navH;
      if (appBarOpacity < 0) {
        // 透明
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        // 不透明
        appBarOpacity = 1.0;
      }

      // 更新透明度
      setState(() {
        _appbarOpacity = appBarOpacity;
        // print('_appbarO: ${_appbarOpacity}');
      });
    });
  }

  @override
  void dispose() {
    // 关闭页面时，销毁滚动监听
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(_dataArr),
    );
  }

  Widget _body(dataArr) {
    var navBgColor = KColors.dynamicColor(context, KColors.wxBgColor, KColors.kNavBgDarkColor);
    navBgColor = navBgColor.withOpacity(_appbarOpacity);

    return Stack(
      children: <Widget>[
        Container(
          color: KColors.dynamicColor(context, KColors.kBgColor, KColors.kBgDarkColor),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: dataArr.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(width: double.infinity, height: _imgNormalHeight);
                }
                WxFriendsCircleModel model = WxFriendsCircleModel.fromJson(dataArr[index - 1]);
                return WxFriendsCircleCell(
                  model: model,
                  // onClickCell: (model) => _clickCell(model['name']),
                  // onClickHeadPortrait: (model) => _jumpInfo(),
                  // onClickComment: (model) => _clickCell('评论'),
                );
              },
            ),
          ),
        ),
        Positioned(top: 0, left: 0, right: 0, height: _imgChangeHeight, child: _header()),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: BaseAppBar(
            '朋友圈',
            bgColor: navBgColor,
            brightness: _appbarOpacity == 1.0 ? Brightness.light : Brightness.dark,
            rightImgPath: 'lib/assets/icon_xiangji.png',
            rightItemCallBack: () {
              _clickNav();
            },
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          // child: const DDImage(
          //   url: 'lib/assets/friends/circle_friend_bg.jpg',
          //   isNet: false
          // )
          child: Image.asset(
            'lib/assets/friends/circle_friend_bg.jpg',
            fit: BoxFit.cover,
          )
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _userInfoVo.nickName ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(_userInfoVo.avatar ?? '')
                    ),
                  ),
                ),
                // onTap: () => _jumpInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
