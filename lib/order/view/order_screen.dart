import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Container(
        child: const Center(
          child: Text(
            '주문',
          ),
        ),
      ),
    );
  }
}
