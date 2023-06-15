import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/component/pagination_list_view.dart';
import 'package:flutter_level_2/common/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_level_2/product/component/product_card.dart';
import 'package:flutter_level_2/product/model/product_model.dart';
import 'package:flutter_level_2/product/provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
        provider: productProvider,
        itemBuilder: <ProductModel>(_, index, model) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                      title: model.restaurant.name,
                      id: model.restaurant.id,
                    ),
                  ),
                );
              },
              child: ProductCard.fromProductModel(model: model));
        });
  }
}
