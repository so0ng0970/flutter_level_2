// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/const/color.dart';
import 'package:flutter_level_2/order/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final DateTime orderDate;
  final Image image;
  final String name;
  final String productDetail;
  final int price;

  const OrderCard({
    Key? key,
    required this.orderDate,
    required this.image,
    required this.name,
    required this.productDetail,
    required this.price,
  }) : super(key: key);

  factory OrderCard.fromModel({required OrderModel model}) {
    final productDetail = model.products.length < 2
        ? model.products.first.product.name
        : '${model.products.first.product.name} 외 ${model.products.length - 1}}';

    return OrderCard(
      orderDate: model.createdAt,
      image: Image.network(
        model.restaurant.thumbUrl,
        height: 50.0,
        width: 50.0,
      ),
      name: model.restaurant.name,
      productDetail: productDetail,
      price: model.totalPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          // 2022.09.01
          '${orderDate.year}.${orderDate.month.toString().padLeft(2, '0')}.${orderDate.day.toString().padLeft(2, '0')} 주문완료',
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                16.0,
              ),
              child: image,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              name,
              style: const TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14.0,
              ),
            ),
            Text(
              '$productDetail $price원',
              style: const TextStyle(
                color: BODY_TEXT_COLOR,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        )
      ],
    );
  }
}
