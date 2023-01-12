import 'dart:convert';

LoginVo loginVoFromJson(String str) => LoginVo.fromJson(json.decode(str));

String loginVoToJson(LoginVo data) => json.encode(data.toJson());

class LoginVo {
  late int code;
  late String message;
  late Data data;

  LoginVo({
    code,
    message,
    data,
  });

  LoginVo.fromJson(Map<String, dynamic> json) {
    LoginVo(
      code: json["code"],
      message: json["message"],
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    id,
    token,
  });

  late int id;
  late String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
  };
}
