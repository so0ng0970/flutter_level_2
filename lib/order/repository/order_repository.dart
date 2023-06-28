import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_level_2/common/dio/custom_interceptor.dart';
import 'package:flutter_level_2/order/model/order_model.dart';
import 'package:flutter_level_2/order/model/post_order_body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return OrderRepository(
    dio,
    baseUrl: 'http://$ip/order',
  );
});

// http://$ip/order
@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;
  @POST('')
  @Headers({
    'accessToken': 'true',
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
