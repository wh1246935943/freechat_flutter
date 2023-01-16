import 'package:flutter/cupertino.dart';
import 'package:freechat/vo/user_info_vo.dart';

class IndexStore extends Object with ChangeNotifier{

  UserInfoVo _userInfo = UserInfoVo();

  get userInfo => _userInfo;

  void set(info){
    _userInfo = info;
    notifyListeners();//通知所有的观察者
  }
}