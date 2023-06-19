import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/provider/go_router.dart';
import 'package:flutter_level_2/user/provider/auth_provider.dart';
import 'package:flutter_level_2/user/view/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
 ProviderScope(
      child: _MyApp(),
    ),
  );
}

class _MyApp extends ConsumerWidget {
   const _MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      routerConfig:router ,

      
    );
  }
}
