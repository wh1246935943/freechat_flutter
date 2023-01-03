import 'package:dio/dio.dart';
// 这个路径自己配
import 'Config.dart';

class Request {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    connectTimeout: HttpConfig.timeout,
    responseType: ResponseType.plain,
    contentType: "application/json"
  );
  static final Dio dio = Dio(baseOptions);
  // 私有方法
  static Future<T> _request<T>(
    String url,
    {
      String method = 'get',
      required Map<String, dynamic> params,
      Interceptor? inter
    }
  ) async {
    // 1.创建单独配置, 我么也可以设置 headers
    Map<String, String> headers = {"Content-Type": "application/json"};
    final options = Options(method: method, headers: headers);
    // 全局拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
      onRequest:(options, handler){
        // Do something before request is sent
        return handler.next(options); //continue
        // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        //
        // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      },
      onResponse:(response,handler) {
        // Do something with response data
        return handler.next(response); // continue
        // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
        // 这样请求将被中止并触发异常，上层catchError会被调用。
      },
      onError: (DioError e, handler) {
        // Do something with response error
        return  handler.next(e);//continue
        // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
        // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      }
    );

    List<Interceptor> inters = [dInter];
    if (inter != null) {
      inters.add(inter);
    }
    // 统一添加到拦截器中
    // dio.interceptors.addAll(inters);
    // 2.发送网络请求
    try {
      Response response = await dio.request(url, data: params, options: options);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }

  // get网络请求
  static Future<T> get<T>(String url,
      {required Map<String, dynamic> params, Interceptor? inter}) async {
    return _request(url, method: 'get', params: params, inter: inter);
  }

  // post网络请求
  static Future<T> post<T>(String url,
      {required Map<String, dynamic> params, Interceptor? inter}) async {
    return _request(url, method: 'post', params: params, inter: inter);
  }
}
