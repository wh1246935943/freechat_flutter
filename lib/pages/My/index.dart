import 'package:flutter/material.dart';
import 'package:freechat/pages/My/my_profile.dart';
import 'package:freechat/pages/common/dd_image/dd_image.dart';
import 'package:freechat/pages/common/img_preview/img_preview.dart';
import 'package:freechat/utils/dd_toast.dart';
import '../../utils/sp_cache.dart';
import '../../vo/user_info_vo.dart';
import '../CircleFriend/index.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  final List<List<String>> funs = [
    ["朋友圈", 'lib/assets/ic_social_circle.png'],
    ["收藏", 'lib/assets/ic_collections.png'],
    ["视频号", 'lib/assets/ic_bottle_msg.png'],
    ["设置", 'lib/assets/ic_settings.png'],
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 1, centerTitle: true, title: const Text('我')),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
            child: Column(children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const MyProfile()
                    )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Navigator
                          .of(context)
                          .push(MaterialPageRoute(
                            builder: (context) => ImgPreview(
                              imgDataArr: [_userInfoVo.avatar]
                            ))
                          );
                      },
                      child: DDImage(
                        url: _userInfoVo.avatar ?? '',
                        width: 100,
                        height: 100,
                      ),
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
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _buildFunsList()),
            ])));
  }

  Widget _buildFunsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: funs.length,
      itemBuilder: (BuildContext context, int index) {
        String name = funs[index][0];
        String iconPath = funs[index][1];
        return (ListTile(
          contentPadding: EdgeInsets.zero,
          leading: DDImage(
            isNet: false,
            url: iconPath,
            height: 30,
            width: 30,
          ),
          title: Text(name),
          trailing: const Icon(Icons.arrow_right),
          onTap: () async {
            if (name != '朋友圈') {
              DDToast.success('敬请期待');
              return;
            }
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const CircleFriend()
              )
            );
          },
        ));
      }
    );
  }
}
