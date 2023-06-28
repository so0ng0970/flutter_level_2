import 'package:dio/dio.dart ' hide Headers;
import 'package:flutter_level_2/common/const/data.dart';
import 'package:flutter_level_2/common/dio/custom_interceptor.dart';
import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/model/pagination_params.dart';
import 'package:flutter_level_2/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../model/restaurant_detail_model.dart';
import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final respository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    return respository;
  },
);

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {required String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginaitionParams? paginaitionParams = const PaginaitionParams(),
  });

  // http://$ip/restaurant/:id/
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
