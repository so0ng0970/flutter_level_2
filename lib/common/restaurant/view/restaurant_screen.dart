import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/restaurant/component/restaurant_card.dart';
import 'package:flutter_level_2/common/restaurant/provider/restaurant_provider.dart';
import 'package:flutter_level_2/common/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(scrollerListner);
  }

  void scrollerListner() async {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터를 추가요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final data = ref.watch(restaurantProvider);
    // 처음 로딩일때
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    // 에러
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // cursorPagination
    // cursorPaginationFetchingMore
    // cursorPaginationRefetching
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length,
        itemBuilder: (_, index) {
          final pItem = cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return RestaurantDetailScreen(
                      title: pItem.name,
                      id: pItem.id,
                    );
                  },
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 16.0,
          );
        },
      ),
    );
  }
}
