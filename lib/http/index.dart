import 'package:dio/dio.dart';
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

Future<Response> httpRequest(url, params, {String method = 'GET'}) async {
  Response response = await dio.request(
    url,
    data: params,
    options: Options(method: method),
  );
  return response;
}
