import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
// 1) 요청을 보낼때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options);
    return super.onRequest(options, handler);
  }

// 2) 응답을 받을때
// 3) 에러가 났을때
}
