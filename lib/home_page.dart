// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(currentUserProvider).when(
                            data: (data) => CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  CachedNetworkImageProvider(data.profilePic),
                            ),
                            error: (error, stackTrace) => const ErrorPage(),
                            loading: () => const Loader(),
                          );
                    },
                  ),
                ],
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
