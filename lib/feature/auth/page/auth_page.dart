import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/common/services/auth_google.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final user = await AuthUser.loginGoogle();
      if (user != null) {
        Navigator.popAndPushNamed(context, Routes.home);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Ups... Algo salio mal',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  void _enterAsGuest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGuest', true);
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (routes) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 150, height: 150),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _enterAsGuest(context),
              child: const Text('Continuar como Invitado'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: const Text('Ingresar con Google'),
            ),
          ],
        ),
      ),
    );
  }
}
