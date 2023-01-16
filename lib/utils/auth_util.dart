import 'package:flutter/material.dart';
import 'package:freechat/utils/sp_cache.dart';

import '../pages/Auth/login.dart';

class AuthUtil {

  static void loginOut(ctx) {
    SpCache.remove('cache_userId');
    SpCache.remove('cache_token');
    SpCache.remove('cache_token');

    Navigator.of(ctx).popUntil(ModalRoute.withName('/'));
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => const Login()));
  }
}