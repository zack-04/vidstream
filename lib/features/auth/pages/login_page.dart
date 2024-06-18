import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/repository/auth_service.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: 450,
                ),
                const Text(
                  'Welcome to VidStream',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  elevation: 0,
                  height: 60,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 215, 212, 212),
                      width: 1,
                    ),
                  ),
                  color: Colors.white,
                  onPressed: () async {
                    await ref.read(authServiceProvider).signInWithGoogle();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Login with google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
