import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/component/pagination_list_view.dart';
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
  Widget build(
    BuildContext context,
  ) {
    return PaginationListView(
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return RestaurantDetailScreen(
                      title: model.name,
                      id: model.id,
                    );
                  },
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: model,
            ),
          );
        },
        provider: restaurantProvider);
  }
}
