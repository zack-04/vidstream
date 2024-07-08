import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/pages/login_page.dart';
import 'package:vidstream/features/auth/pages/username_page.dart';
import 'package:vidstream/home_page.dart';

class NextScreen extends ConsumerWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        } else if (!snapshot.hasData) {
          return const LoginPage();
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            final user = FirebaseAuth.instance.currentUser;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return UserNamePage(
                displayName: user!.displayName!,
                profilePic: user.photoURL!,
                email: user.email!,
              );
            }
            return const HomePage();
          },
        );
      },
    );
  }
}
