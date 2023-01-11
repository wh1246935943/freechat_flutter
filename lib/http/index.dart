import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: 'http://43.136.217.59:9001/doudou',
  connectTimeout: 10000,
  receiveTimeout: 10000
);
Dio dio = Dio(options);

Future<Response> httpRequest(url, params, {String method = 'GET'}) async {
  Response response = await dio.request(
    url,
    data: params,
    options: Options(method: method),
  );
  return response;
}
