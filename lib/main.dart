import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/common/theme/dark_theme.dart';
import 'package:learnquest/common/theme/light_theme.dart';
import 'package:learnquest/feature/auth/page/auth_page.dart';
import 'package:learnquest/feature/splash_screen.dart';
import 'package:learnquest/feature/welcome/page/welcome_page.dart';
import 'package:learnquest/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const SplashScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
