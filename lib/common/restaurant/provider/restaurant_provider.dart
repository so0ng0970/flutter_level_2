import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurnatStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurnatStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurnatStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;
  RestaurnatStateNotifier({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        ) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // true
    // 추가로 데이터 더 가져오기
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true -CursorPaginationLoading()
    bool forceRefech = false,
  }) async {
    // 5가지 가능성
    // State의 상태
    // [상태가]
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
    // 3) CursorPaginationError - 에러가 있는 상태
    // 4) CursorPaginationRefetch - 첫번째 페이지부터 다시 데이터를 가져올때
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때

    // 바로 반환되는 상황
    // 1) hasmore =false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
    // 2) 로딩중 - fetchMore : true
    //    fetchMore가 아닐때 - 새로고침의 의도가 있을 수 있다
    if (state is CursorPagination && !forceRefech) {
      // 100퍼 타입이 같아야지 as를 쓸 수 있다
      final pState = state as CursorPagination;

      if (!pState.meta.hasMore) {
        return;
      }
    }
    final isLoading = state is CursorPaginationLoading;
    final isRefeching = state is CursorPaginationRefeching;
    final isFetchingMore = state is CursorPaginationFetchingMore;
    // 2번 반환상황
    if (fetchMore && (isLoading || isRefeching || isFetchingMore)) {
      return;
    }
  }
}
