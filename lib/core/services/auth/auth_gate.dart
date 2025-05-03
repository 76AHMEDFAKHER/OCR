import 'package:flutter/material.dart';
import 'package:ocr/presentaion/views/home_view.dart';
import 'package:ocr/presentaion/views/profile_view.dart';
import 'package:ocr/screens/signin_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return HomeView();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
