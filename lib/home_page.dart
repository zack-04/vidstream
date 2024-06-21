// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'VidStream',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(width: 4),
                    const Spacer(),
                    SizedBox(
                      height: 45,
                      child: ImageButton(
                        image: "cast.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ImageButton(
                        image: "notification.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                    SizedBox(
                      height: 43,
                      child: ImageButton(
                        image: "search.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: pages[currentIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          if (index != 2) {
            currentIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CreateBottomSheet(),
            );
          }
        },
      ),
    );
  }
}
