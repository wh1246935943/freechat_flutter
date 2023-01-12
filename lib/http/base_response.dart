import 'dart:convert';

class BaseResponse<T> {
  int? code;
  String? message;
  dynamic data;

  BaseResponse({
    this.code,
    this.message,
    this.data,
  });

  BaseResponse.fromJson(Map<String, dynamic> json) {

    // if (json['data'] != null && json['data']!='null') {
		// 	data = jsonDecode(json['data']);
		// }

    code = json["code"];
    message = json["message"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
		// 	data['data'] = this.data;
		// }
    data['code'] = code;
		data['message'] = message;
    data['data'] = data;
    return data;
  }
}