class LoginVo {
  LoginVo({
    this.id,
    this.token,
  });

  int? id;
  String? token;

  factory LoginVo.fromJson(Map<String, dynamic> json) => LoginVo(
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
  };
}
