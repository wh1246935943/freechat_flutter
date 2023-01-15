import 'package:flutter/material.dart';
import 'package:freechat/http/index.dart';

Map<String, List<dynamic>> fields = {
  'userName': ['用户名', RegExp(r"^[a-zA-Z0-9·&-_\\/]{1,30}$")],
  'password': ['密码', RegExp(r"^[a-zA-Z0-9_-|,.<>]{4,16}$")],
  'nickName': ['昵称', RegExp(r"^[\u4e00-\u9fa5a-zA-Z0-9·&-_\\/]{1,30}$")],
  'phoneNumber': ['手机号', RegExp(r"^[1]([3][0-9]{1}|[5-9][0-9]{1})[0-9]{8}$")],
  'email': ['邮箱', RegExp(r"^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")],
  'region': ['地区', null],
  // 'avatar': '',
  'verCode': ['验证码', RegExp(r"^[0-9]{6}$")],
};

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  final GlobalKey _formKey = GlobalKey<FormState>();
  Map<String, String> submitInfo = Map();
  late AnimationController controller;
  bool _isObscure = true;
  bool _loading = false;
  bool _codeLoading = false;
  Color _eyeColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void registerHandel(context) async {
    setState(() => _loading = true);
    try {
      await httpRequest(
        '/auth/register',
        params: submitInfo,
        method: 'POST'
      );
    } catch (e) {};
    // 成功与否都关闭loading
    setState(() => _loading = false);
  }

  void getVerCode() async {
    setState(() => _codeLoading = true);
    try {
      await httpRequest('/auth/verCode?email=${submitInfo['email']}');
    } catch (e) {};
    // 成功与否都关闭loading
    setState(() => _codeLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('注册账号')
      ),
      body: Form(
        key: _formKey, // 设置globalKey，用于后面获取FormStat
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 10),
            // 用户名
            buildEmailTextField('userName'),
            // 密码
            buildPasswordTextField('password', ctx: context),
            // 确认密码
            // buildPasswordTextField('userName', ctx: context),
            // 用户昵称
            buildEmailTextField('nickName'),
            // 手机号
            buildEmailTextField('phoneNumber'),
            // 邮箱
            buildEmailTextField('email'),
            // 地区
            buildEmailTextField('region'),
            // 验证码
            buildEmailTextField('verCode'),
            // 获取验证码
            const SizedBox(height: 60),
            getVerCodeText(),
            // 登录按钮
            const SizedBox(height: 60),
            buildRegisterButton(context),
          ]
        )
      )
    );
  }

  Widget getVerCodeText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          child: Text(
            '获取验证码',
            style: TextStyle(color: _codeLoading ? Colors.grey : Colors.green)
          ),
          onTap: () {
            if (_codeLoading) return;
            getVerCode();
          },
        ),
      ),
    );
  }

  Widget buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            // 设置圆角
            shape: MaterialStateProperty.all(
              const StadiumBorder(side: BorderSide(style: BorderStyle.none))
            )
          ),
          child: _loading ? const Center(child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color.fromARGB(255, 255, 255, 255),
            )
          )) : Text('注册', style: Theme.of(context).primaryTextTheme.headline5),
          onPressed: () {
            // 表单校验通过才会继续执行
            if ((_formKey.currentState as FormState).validate()) {
              (_formKey.currentState as FormState).save();
              registerHandel(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildEmailTextField(String field) {
    var desc = fields[field]![0];
    var reg = fields[field]![1];
    return TextFormField(
      decoration: InputDecoration(labelText: desc),
      validator: (v) {
        if (reg != null && !reg.hasMatch(v!)) {
          return '$desc格式错误';
        }
        return null;
      },
      onChanged: (v) {
        setState(() => submitInfo[field] = v);
      },
    );
  }

  Widget buildPasswordTextField(String field, {required BuildContext ctx}) {
    return TextFormField(
      obscureText: _isObscure, // 是否显示文字
      onChanged: (v) {
        setState(() => submitInfo['password'] = v!);
      },
      validator: (v) {
        if (v!.isEmpty) {
          return '密码格式错误';
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
                  : Theme.of(ctx).iconTheme.color)!;
            });
          },
        )
      )
    );
  }
}
