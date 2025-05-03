import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ocr/app_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  try {
    await Supabase.initialize(
      url: 'https://mmkrtiqfogqgjpqxhipw.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ta3J0aXFmb2dxZ2pwcXhoaXB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyODU3NjgsImV4cCI6MjA2MTg2MTc2OH0.JbDiYJIas4XoYoyWHKGosZVOT33XLetYhN2Gtt3BMWk',
    );
    log('Supabase initialized successfully');
  } catch (e) {
    log('Error initializing Supabase: $e');
  }

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
