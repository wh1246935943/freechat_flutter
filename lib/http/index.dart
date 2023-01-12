import 'package:dio/dio.dart';

import '../utils/dd_toast.dart';
import 'base_response.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:cookie_jar/cookie_jar.dart';

var options = BaseOptions(
  baseUrl: 'http://43.136.217.59:9001/doudou',
  connectTimeout: 10000,
  receiveTimeout: 10000
);
Dio dio = Dio(options);
// CookieJar cookieJar= CookieJar();
// dio.interceptors.add(CookieManager(cookieJar));

Future<BaseResponse> httpRequest(url, params, {String method = 'GET', bool isMsg = true, String msg = ''}) async {
  Response response = await dio.request(
    url,
    data: params,
    options: Options(method: method),
  );

  BaseResponse responseData = BaseResponse.fromJson(response.data);
  int errorCode = responseData.code ?? -1;
  String errorMessage = responseData.message ?? '出现了一个异常，但这不是你设备或网络的问题';

  String emsg = "$errorCode: $errorMessage";
  if (msg != '') {
    emsg = msg;
    isMsg = true;
  }

  if (errorCode != 200) {
    DDToast.error(emsg);
    throw Exception(emsg);
  }

  if (isMsg) {
    DDToast.info(emsg);
  }

  return responseData;
}
