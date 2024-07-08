import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/repository/auth_service.dart';
import 'package:vidstream/features/theme/theme_provider.dart';
import 'package:vidstream/next_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Dark theme',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: Switch(
                  value: ref.watch(themeProvider) == ThemeMode.dark,
                  onChanged: (bool value) {
                    ref.read(themeProvider.notifier).toggleTheme(value);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () async {
                  await ref.read(authServiceProvider).signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextScreen(),
                    ),
                  );
                },
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
