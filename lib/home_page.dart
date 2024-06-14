// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/image_button.dart';

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
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 4),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      height: 42,
                      child: ImageButton(
                        image: "cast.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    child: ImageButton(
                      image: "notification.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 15),
                    child: SizedBox(
                      height: 41.5,
                      child: ImageButton(
                        image: "search.png",
                        onPressed: () {},
                        haveColor: false,
                      ),
                    ),
                  ),
                  // Consumer(
                  //   builder: (context, ref, child) {
                  //     return ref.watch(currentUserProvider).when(
                  //           data: (currentUser) => Padding(
                  //             padding: const EdgeInsets.only(right: 12),
                  //             child: GestureDetector(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) => AccountPage(
                  //                       user: currentUser,
                  //                     ),
                  //                   ),
                  //                 );
                  //               },
                  //               child: CircleAvatar(
                  //                 radius: 14,
                  //                 backgroundColor: Colors.grey,
                  //                 backgroundImage: CachedNetworkImageProvider(
                  //                   currentUser.profilePic,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           error: (error, stackTrace) => const ErrorPage(),
                  //           loading: () => const Loader(),
                  //         );
                  //   },
                  // ),
                ],
              ),
              // Expanded(
              //   child: pages[currentIndex],
              // ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   onPressed: (index) {
      //     if (index != 2) {
      //       currentIndex = index;
      //       setState(() {});
      //     } else {
      //       showModalBottomSheet(
      //         context: context,
      //         builder: (context) => const CreateBottomSheet(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
