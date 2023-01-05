import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:freechat/pages/Index/index.dart';
import 'package:freechat/http/index.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

// import '../Store/IndexStore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey _formKey = GlobalKey<FormState>();
  late String _userName, _password;
  late AnimationController controller;
  bool _isObscure = true;
  bool _loading = false;
  Color _eyeColor = Colors.grey;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void loginHandel(context) async {
    setState(() => _loading = true);
    String message = '';
    int code = -1; 
    try {
      var respJson = await httpRequest(
        '/auth/login',
        {'userName': _userName, 'password': _password},
        method: 'POST'
      );
      // 解析接口返回的数据
      Map<String, dynamic> resp = await jsonDecode(respJson.toString());
      message = resp['message'];
      code = resp['code'];
    } catch (e) {};
    // 成功与否都关闭loading
    setState(() => _loading = false);
    // 返回状态为200时登录成功
    if (code == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (context) => const Index())
      );
      return;
    }
    // 登录失败，弹出错误提示
    Fluttertoast.showToast(
      msg: "$code: $message",
      gravity: ToastGravity.BOTTOM ,
      backgroundColor: Colors.red
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            // 距离顶部一个工具栏的高度
            const SizedBox(height: kToolbarHeight),
            // Login
            buildTitle(),
            // Login下面的下划线
            buildTitleLine(),
            const SizedBox(height: 60),
            // 输入邮箱
            buildEmailTextField(),
            const SizedBox(height: 30),
            // 输入密码
            buildPasswordTextField(context),
            // 忘记密码
            buildForgetPasswordText(context),
            const SizedBox(height: 60),
            // 登录按钮
            buildLoginButton(context),
            const SizedBox(height: 40),
            // 注册账号文本按钮
            buildRegisterText(context),
            // 加载动画
          ]
        )
      )
    );
  }

  Widget buildRegisterText(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?'),
            GestureDetector(
              child: const Text('点击注册', style: TextStyle(color: Colors.green)),
              onTap: () {
                // loginHandel(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
              // 设置圆角
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          child: _loading ? const Center(child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color.fromARGB(255, 255, 255, 255),
              )
            )) : Text('登录',
              style: Theme.of(context).primaryTextTheme.headline5),
          onPressed: () {
            // 表单校验通过才会继续执行
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              print('userName: $_userName, password: $_password');
              loginHandel(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            // Navigator.pop(context);
            print("忘记密码");
          },
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
        obscureText: _isObscure, // 是否显示文字
        onSaved: (v) => _password = v!,
        validator: (v) {
          if (v!.isEmpty) {
            return '请输入密码';
          }
        },
        decoration: InputDecoration(
            labelText: "密码",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                // 修改 state 内部变量, 且需要界面内容更新, 需要使用 setState()
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = (_isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color)!;
                });
              },
            )));
  }

  Widget buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: '账号'),
      validator: (v) {
        var emailReg = RegExp(
            r"^[a-zA-Z0-9_-]{6,20}$");
        if (!emailReg.hasMatch(v!)) {
          return '请输入正确的免聊账号';
        }
      },
      onSaved: (v) => _userName = v!,
    );
  }

  Widget buildTitleLine() {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.black,
            width: 40,
            height: 2,
          ),
        ));
  }

  Widget buildTitle() {
    return const Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          '登录',
          style: TextStyle(fontSize: 42),
        ));
  }
}
