import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ocr/app_route.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  try {
    await Supabase.initialize(
      url: 'http://192.168.0.173:54321',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
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
