import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/model/model_with_id.dart';
import 'package:flutter_level_2/common/model/pagination_params.dart';
import 'package:flutter_level_2/common/repository/base_pagination_repository.dart';
import 'package:flutter_level_2/common/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider<
T extends IModelWithId,
U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        );
  Future<void> paginate({
    int fetchCount = 20,
    // true
    // 추가로 데이터 더 가져오기
    // false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true -CursorPaginationLoading()
    bool forceRefech = false,
  }) async {
    try {
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

      // PaginationParams 생성
      PaginaitionParams paginaitionParams = PaginaitionParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        state = CursorPaginationFetchingMore<T>(
          meta: pState.meta,
          data: pState.data,
        );

        paginaitionParams = paginaitionParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행

        if (state is CursorPagination && !forceRefech) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefeching(
            meta: pState.meta,
            data: pState.data,
          );
        }
        // 나머지 상황
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginaitionParams: paginaitionParams,
      );
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        // 기존 데이터의 새로운 데이터 추가
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 불러오지 못했습니다');
    }
  }

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
    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>(
            (e) => e.id == id ? resp : e,
          )
          .toList(),
    );
  }
}
