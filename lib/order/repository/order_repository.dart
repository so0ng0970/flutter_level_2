import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_level_2/common/dio/custom_interceptor.dart';
import 'package:flutter_level_2/common/model/pagination_params.dart';
import 'package:flutter_level_2/order/model/order_model.dart';
import 'package:flutter_level_2/order/model/post_order_body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/repository/base_pagination_repository.dart';

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
abstract class OrderRepository
    implements IBasePaginationRepository<OrderModel> {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<OrderModel>> paginate(
      {@Queries()
          PaginaitionParams? paginaitionParams = const PaginaitionParams()});

  @POST('')
  @Headers({
    'accessToken': 'true',
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
