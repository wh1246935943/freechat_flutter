import 'package:flutter/material.dart';
import 'package:freechat/pages/Auth/login.dart';
import 'package:freechat/utils/dd_toast.dart';

import '../../http/index.dart';
import '../../utils/sp_cache.dart';
import '../../vo/user_info_vo.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  final List<String> funs = <String>['收藏', '朋友圈', '视频号', '设置'];
  UserInfoVo _userInfoVo = UserInfoVo();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo() async {
    var respJson = await httpRequest('/user/info');

    setState(() {
      _userInfoVo = UserInfoVo.fromJson(respJson.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 1, centerTitle: true, title: const Text('我')),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    _userInfoVo.avatar ?? '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'lib/assets/default_avatar.jpg',
                      height: 100,
                      width: 100)
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(_userInfoVo.nickName ?? '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text("免聊号: ${_userInfoVo.userName ?? ''}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text("个性签名: ${_userInfoVo.personalitySign ?? ''}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _buildFunsList()),
              Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: _buildLoginout(context))
            ])));
  }

  Widget _buildFunsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: funs.length,
        itemBuilder: (BuildContext context, int index) {
          String name = funs[index];
          return (ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.network(
              _userInfoVo.avatar ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'lib/assets/default_avatar.jpg',
                height: 40,
                width: 40
              )
            ),
            title: Text(name),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              DDToast.info(name);
            },
          ));
        });
  }

  Widget _buildLoginout(BuildContext context) {
    return SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
            style: ButtonStyle(
                // 设置圆角
                shape: MaterialStateProperty.all(const StadiumBorder(
                    side: BorderSide(style: BorderStyle.none)))),
            child: Text('退出登录',
                style: Theme.of(context).primaryTextTheme.headline5),
            onPressed: () {
              _loginout(context);
            }));
  }

  void _loginout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("确定退出吗？"),
          actions: [
            TextButton(
              onPressed: () {
                DDToast.warn('取消了');
                Navigator.of(context).pop();
              },
              child: const Text("取消"),
            ),
            TextButton(
                onPressed: () {
                  SpCache.remove('cache_userId');
                  SpCache.remove('cache_token');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) => const Login()));
                },
                child: const Text("确定"))
          ],
        );
      },
    );
  }
}
