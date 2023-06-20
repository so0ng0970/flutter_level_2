import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/const/color.dart';
import 'package:flutter_level_2/common/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
