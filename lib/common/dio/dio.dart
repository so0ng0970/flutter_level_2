import 'package:dio/dio.dart';
import 'package:flutter_level_2/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  CustomInterceptor({
    required this.storage,
  });
// 1) 요청을 보낼때
// 요청이 보내질때마다
// 요청이 header에 ['accessToken'] == 'true'라는 값이 있다면
// 실제 토큰을 가져와서 (storage에서) 'authorization': 'Bearer $token'으로
// 헤더를 변경한
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    return super.onRequest(options, handler);
  }

// 2) 응답을 받을때
// 3) 에러가 났을때
}
