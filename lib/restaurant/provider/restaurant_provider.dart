import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/provider/pagination_provider.dart';
import 'package:flutter_level_2/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../repository/restaurant_repository.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  if (state is! CursorPagination) {
    return null;
  }
// firstWhere 존재 하지 않으면 에러 던짐
// firstWhereOrNull 존재 하지 않으면 null 던짐
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurnatStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurnatStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurnatStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  @override
  RestaurnatStateNotifier({
    required super.repository,
  });

  @override
  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (cursirPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }
    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    // 요청 id : 10
    // list.where((e) => e.id == 10) 데이터 x
    //데이터가 없을 때는 캐시의 끝에다가 데이터를 추가한다
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>(
              (e) => e.id == id ? resp : e,
            )
            .toList(),
      );
    }
  }
}
