import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/my_channel/parts/buttons.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_bar.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_pages.dart';
import 'package:vidstream/features/channel/my_channel/parts/top_header.dart';
import 'package:vidstream/features/search/pages/search_page.dart';

class MyChannelPage extends ConsumerWidget {
  const MyChannelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) {
            return DefaultTabController(
              length: 7,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(currentUser.displayName),
                  actions: [
                    SizedBox(
                      height: 45,
                      child: ImageButton(
                        image: "cast.png",
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ImageButton(
                        image: "notification.png",
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 43,
                      child: ImageButton(
                        image: "search.png",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            currentUser.coverImageUrl.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          currentUser.coverImageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                            TopHeader(
                              userModel: currentUser,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'More about this channel',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : const Color.fromRGBO(96, 96, 96, 1.0),
                                  ),
                                ),
                                const Icon(Icons.arrow_right_outlined)
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Buttons(),
                            const SizedBox(height: 20),
                            const PageTabBar(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TabPages(),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
