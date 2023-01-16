import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/dd_toast.dart';
import 'base_response.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

var options = BaseOptions(
  baseUrl: 'http://43.136.217.59:9001/doudou',
  connectTimeout: 10000,
  receiveTimeout: 10000
);
Dio dio = Dio(options);

Future<BaseResponse> httpRequest(url, {params, String method = 'GET', bool isMsg = true, String msg = ''}) async {
  /// 获取应用文档的路径
  /// 将cookies信息保存在这个文件下，以实现持久化数据
  var freechatDir = await getApplicationDocumentsDirectory();
  PersistCookieJar persistCookieJar = PersistCookieJar(storage: FileStorage('${freechatDir.path}/.cookies/'));

  /// 添加到拦截器，以使其生效
  dio.interceptors.add(CookieManager(persistCookieJar));
  
  /// 发起请求
  Response response = await dio.request(
    url,
    data: params,
    options: Options(method: method),
  );

  DDToast.error('${response.statusCode}');

  if (response.statusCode != 200) {
    DDToast.error(response.statusCode.toString());
    throw Exception('操作异常');
  }

  /// 解析公共的返回数据
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
    // DDToast.info(emsg);
  }

  return responseData;
}
