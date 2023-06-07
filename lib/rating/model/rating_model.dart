// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_level_2/common/model/model_with_id.dart';
import 'package:flutter_level_2/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls,
  )
  final List<String> imgUrls;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
  });
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
