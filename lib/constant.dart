import 'dart:ui';

class AppColors {
  static const Color primary = Color.fromARGB(255, 0, 0, 0);
  static const Color secondary = Color.fromARGB(255, 198, 152, 14);
  static const Color accent = Color.fromARGB(255, 252, 250, 241);
  static const Color accent2 = Color.fromARGB(255, 202, 202, 202);
}

class AppTextStyles {
  // Example text styles (add as needed)
  static final TextStyle heading = TextStyle(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body = TextStyle(
    color: AppColors.secondary,
    fontSize: 16,
  );
}

class AppConstants {
  // Add other constants here (e.g., padding, margins, etc.)
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
}
