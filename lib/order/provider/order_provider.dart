import 'package:flutter_level_2/order/model/order_model.dart';
import 'package:flutter_level_2/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final OrderProvider =
    StateNotifierProvider<OrderStateNotifier, List<OrderModel>>((ref) {
  return OrderStateNotifier(ref: ref);
});

class OrderStateNotifier extends StateNotifier<List<OrderModel>> {
  final Ref ref;

  OrderStateNotifier({required this.ref}) : super([]);

  Future<void> postOrder() {
    final uuid = const Uuid();

    final id = uuid.v4();

    final state = ref.read(basketProvider);

    return;
  }
}
