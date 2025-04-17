import 'package:flutter/material.dart';
import 'package:ocr/app_route.dart';
import 'package:ocr/presentaion/views/home_view.dart';
import 'package:ocr/presentaion/views/splash_view.dart';

void main() {
  runApp(const OCR());
}

class OCR extends StatelessWidget {
  const OCR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'OCR App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRoute.router,
    );
  }
}
