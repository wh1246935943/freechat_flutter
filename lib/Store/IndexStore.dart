import 'package:flutter/cupertino.dart';

class IndexStore extends Object with ChangeNotifier{

  bool _loginState = false;

  get loginState => _loginState;

  void set(){
    _loginState = !_loginState;
    notifyListeners();//通知所有的观察者
  }
}