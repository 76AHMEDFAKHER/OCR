import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _client.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  //-------------------------------------------------4
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _client.auth.signUp(email: email, password: password);
  }

  //-------------------------------------------------4
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  //-------------------------------------------------4
  String? getCurrentUserEmail() {
    final session = _client.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
