import 'package:flutter/material.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Or sign in with',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(
              'assets/icons/11244080_x_twitter_elon musk_twitter new logo_icon.png',
            ),
            const SizedBox(width: 20),
            _socialButton('assets/icons/7123025_logo_google_g_icon.png'),
            const SizedBox(width: 20),
            _socialButton('assets/icons/104498_facebook_icon.png'),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(String asset) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(asset, fit: BoxFit.scaleDown, color: Colors.white),
      ),
    );
  }
}
