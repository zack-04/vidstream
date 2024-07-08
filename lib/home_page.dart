// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidstream/features/contents/bottom_nav_bar.dart';
import 'package:vidstream/features/upload/upload_bottom_sheet.dart';
import 'package:vidstream/pages_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: pages[currentIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          if (index != 2) {
            currentIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              backgroundColor: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.95)
                  : Colors.white),
              context: context,
              builder: (context) => const CreateBottomSheet(),
            );
          }
        },
      ),
    );
  }
}
