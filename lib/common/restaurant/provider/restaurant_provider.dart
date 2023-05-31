import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/restaurant/model/restaurant_model.dart';
import 'package:flutter_level_2/common/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurnatStateNotifier, List<RestaurantModel>>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurnatStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurnatStateNotifier extends StateNotifier<CursorPagination> {
  final RestaurantRepository repository;
  RestaurnatStateNotifier({
    required this.repository,
  }) : super(CursorPagination(meta: meta, data: data)) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
    state = resp.data;
  }
}
