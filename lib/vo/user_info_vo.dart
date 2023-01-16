// To parse this JSON data, do
//
//     final userInfoVo = userInfoVoFromJson(jsonString);

import 'dart:convert';

UserInfoVo? userInfoVoFromJson(String str) => UserInfoVo.fromJson(json.decode(str));

String userInfoVoToJson(UserInfoVo? data) => json.encode(data!.toJson());

class UserInfoVo {
    UserInfoVo({
        this.id,
        this.userName,
        this.nickName,
        this.personalitySign,
        this.phoneNumber,
        this.onlineState,
        this.region,
        this.avatar,
        this.email,
        this.outTradeNo,
        this.createTime,
        this.accountStatus,
    });

    int? id;
    String? userName;
    String? nickName;
    String? personalitySign;
    String? phoneNumber;
    int? onlineState;
    String? region;
    String? avatar;
    String? email;
    dynamic outTradeNo;
    DateTime? createTime;
    int? accountStatus;

    factory UserInfoVo.fromJson(Map<String, dynamic> json) => UserInfoVo(
        id: json["id"],
        userName: json["userName"],
        nickName: json["nickName"],
        personalitySign: json["personalitySign"],
        phoneNumber: json["phoneNumber"],
        onlineState: json["onlineState"],
        region: json["region"],
        avatar: json["avatar"],
        email: json["email"],
        outTradeNo: json["outTradeNo"],
        createTime: DateTime.parse(json["createTime"]),
        accountStatus: json["accountStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "nickName": nickName,
        "personalitySign": personalitySign,
        "phoneNumber": phoneNumber,
        "onlineState": onlineState,
        "region": region,
        "avatar": avatar,
        "email": email,
        "outTradeNo": outTradeNo,
        "createTime": createTime?.toIso8601String(),
        "accountStatus": accountStatus,
    };
}
