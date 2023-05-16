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
          children: [
            CustomTextFormField(
              onchanged: (String value) {},
              hintText: '이메일을 입력해주세요',
            ),
            CustomTextFormField(
              onchanged: (String value) {},
              obscureText: true,
              hintText: '비밀번호를 입력해주세요',
            ),
          ],
        ),
      ),
    );
  }
}
