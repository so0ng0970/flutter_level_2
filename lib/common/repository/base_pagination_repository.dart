import 'package:flutter_level_2/common/model/cursor_pagination_model.dart';
import 'package:flutter_level_2/common/model/model_with_id.dart';
import 'package:flutter_level_2/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginaitionParams? paginaitionParams = const PaginaitionParams(),
  });
}
