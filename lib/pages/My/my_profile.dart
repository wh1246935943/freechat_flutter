import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../http/index.dart';
import '../../utils/auth_util.dart';
import '../../utils/dd_toast.dart';
import '../../utils/sp_cache.dart';
import '../../vo/user_info_vo.dart';
import '../common/dd_image/dd_image.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  // Map<String, List<dynamic>> infoList = {
  //   'avatar': ['头像', 'avatar'],
  //   'nickName': ['名字', 'nickName'],
  //   'userName': ['用户名', 'userName'],
  //   'phoneNumber': ['手机号', 'phoneNumber'],
  //   'email': ['邮箱', 'email'],
  //   'personalitySign': ['签名', 'personalitySign'],
  //   'region': ['地区', 'region'],
  // };

  // final List<String> infoList = <String>['头像', '名字', '视频号', '设置'];

  UserInfoVo _userInfoVo = UserInfoVo();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  void getUserInfo() async {
    var respString = SpCache.getObject('user_info_vo');
    setState(() => _userInfoVo = UserInfoVo.fromJson(respString));
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
                AuthUtil.loginOut(context);
              },
              child: const Text("确定")
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1, centerTitle: true, title: const Text('个人信息')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: DDImage(
                url: _userInfoVo.avatar ?? '',
                width: 40,
                height: 40,
              ),
              title: const Text('头像'),
              onTap: () async {
                var paths = (await FilePicker.platform.pickFiles(
                  type: FileType.any,
                  allowMultiple: false,
                  // onFileLoading: (FilePickerStatus status) => print(status),
                ))?.files;

                var path = paths?[0].path;
                var name = paths?[0].name;
                if (path == null) return;

                var formData = FormData.fromMap({
                  'file': await MultipartFile.fromFile(path, filename: name)
                });

                var respJson = await httpRequest('/file/upload', method: 'post', params: formData);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: _buildLoginout(context)
            )
          ],
        ),
      )
    );
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
}
