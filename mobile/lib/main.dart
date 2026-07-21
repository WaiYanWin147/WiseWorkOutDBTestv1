import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/auth/welcome_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tltbtwctxaxsevcxwwco.supabase.co',
    publishableKey: 'sb_publishable_7Wige7bkmk3CgHxcch1N6w_aZcBVR7i',
  );

  runApp(const ShapeRushApp());
}

class ShapeRushApp extends StatelessWidget {
  const ShapeRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShapeRush',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const WelcomeScreen(),
    );
  }
}