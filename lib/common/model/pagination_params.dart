import 'package:json_annotation/json_annotation.dart';
part 'pagination_params.g.dart';

@JsonSerializable()
class PaginaitionParams {
  final String? after;
  final int? count;
  const PaginaitionParams({
    this.after,
    this.count,
  });

  PaginaitionParams copyWith({
    String? after,
    int? count,
  }) {
    return PaginaitionParams(
      after: after ?? after,
      count: count ?? count,
    );
  }

  factory PaginaitionParams.fromJson(Map<String, dynamic> json) =>
      _$PaginaitionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginaitionParamsToJson(this);
}
