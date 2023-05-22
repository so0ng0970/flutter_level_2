import 'package:dio/dio.dart ' hide Headers;
import 'package:flutter_level_2/common/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {required String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  @GET('/')
  Future paginate<RestaurantModel>();

  // http://$ip/restaurant/:id/
  @GET('/{id}')
  @Headers({
    'authorization':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjg0NzUwMzMwLCJleHAiOjE2ODQ3NTA2MzB9.ynxcpaAHqnbZplbhkW0FtROaP2aJ7QWyDUNRI271YqM'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
