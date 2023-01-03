import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: 'http://freechat.bilinstore.com/doudou',
  connectTimeout: 5000,
  receiveTimeout: 3000,
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
