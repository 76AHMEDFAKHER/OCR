import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocr/presentaion/camera_view.dart';
import 'package:ocr/presentaion/views/getStarted_view.dart';
import 'package:ocr/presentaion/views/home_view.dart';
import 'package:ocr/presentaion/views/splash_view.dart';
import 'package:ocr/screens/signin_screen.dart';
import 'package:ocr/screens/signup_screen.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: '/camera',
        name: 'camera',
        builder: (context, state) => CameraView(),
      ),
      GoRoute(
        path: '/getStarted',
        name: 'getStarted',
        builder: (context, state) => const GetStarted(),
      ),
      GoRoute(
        path: '/lib/screens/signup_screen.dart',
        name: 'signup',
        builder: (context, state) => SignUpScreen(),
      ),
    ],
  );
}
