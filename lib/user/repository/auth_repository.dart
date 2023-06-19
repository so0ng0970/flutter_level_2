import 'package:dio/dio.dart';
import 'package:flutter_level_2/common/model/login_response.dart';
import 'package:flutter_level_2/common/utils/data_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../../common/dio/custom_interceptor.dart';
import '../../common/model/token_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(
    baseUrl: 'https://$ip/auth',
    dio: dio,
  );
});

class AuthRepository {
  // 'http://$ip/auth'
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64(
      '$username:$password',
    );
    final resp = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {'authorization': 'Basic $serialized'},
      ),
    );
    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post(
      '$baseUrl/token',
      options: Options(
        headers: {
          'refreshToken': 'true',
        },
      ),
    );
    return TokenResponse.fromJson(
      resp.data,
    );
  }
}
