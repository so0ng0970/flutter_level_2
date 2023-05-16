import 'package:flutter/material.dart';
import 'package:flutter_level_2/common/component/custom_text_form_field.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomTextFormField(
              onchanged: null,
              hintText: '이메일을 입력해주세요',
            ),
          ],
        ),
      ),
    );
  }
}
