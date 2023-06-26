// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_level_2/common/model/model_with_id.dart';
import 'package:flutter_level_2/common/restaurant/model/restaurant_model.dart';
import 'package:flutter_level_2/common/utils/data_utils.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  final String id;
  final String name;
  final String detail;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final int price;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);
}

@JsonSerializable()
class OrderProductAndCountModel {
  final OrderProductModel product;
  final int count;

  OrderProductAndCountModel({
    required this.product,
    required this.count,
  });
  factory OrderProductAndCountModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductAndCountModelFromJson(json);
}

@JsonSerializable()
class OrderModel implements IModelWithId {
  @override
  final String id;
  final List<OrderProductAndCountModel> products;
  final int totalPrice;
  final RestaurantModel restaurant;
  @JsonKey(fromJson: DataUtils.stringToDateTime)
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalPrice,
    required this.restaurant,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
