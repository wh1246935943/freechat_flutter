// import 'package:json_annotation/json_annotation.dart';

// part 'BaseResponse.g.dart';

// @JsonSerializable()
// class BaseResponse {
//   // 后台返回的错误码
//   late int code;
//   // 返回的信息
//   late String message;
//   // 返回的数据
//   late Object data;

//   BaseResponse(this.code, this.message, this.data);

//   BaseResponse.fromJson(Map<String, dynamic> json) {
//     BaseResponse(
//       code = json['code'],
//       message = json['message'],
//       data = json['data'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": data,
//       };
// }
