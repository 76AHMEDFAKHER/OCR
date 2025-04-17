import 'package:flutter/material.dart';
import 'package:ocr/presentaion/views/getStarted_view.dart';
import 'package:ocr/presentaion/views/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animateController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animateController,
      curve: Curves.slowMiddle,
    );
    _animateController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(opacity: animation, child: GetStarted());
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.from(alpha: 1, red: 0, green: 0, blue: 0),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Image.asset(
            'assets/images/Screenshot 2025-04-10 112820.png',
            width: 500,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
