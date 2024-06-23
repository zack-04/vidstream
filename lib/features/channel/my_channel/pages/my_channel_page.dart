import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/my_channel/parts/buttons.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_bar.dart';
import 'package:vidstream/features/channel/my_channel/parts/tab_pages.dart';
import 'package:vidstream/features/channel/my_channel/parts/top_header.dart';

class MyChannelPage extends ConsumerWidget {
  const MyChannelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(currentUserProvider).when(
            data: (currentUser) {
              return DefaultTabController(
                length: 7,
                child: Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopHeader(
                            userModel: currentUser,
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                'More about this channel',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              Icon(Icons.arrow_right_outlined)
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Buttons(),
                          const SizedBox(height: 20),
                          const PageTabBar(),
                          const SizedBox(height: 20),
                          const TabPages(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) => const ErrorPage(),
            loading: () => const Loader(),
          ),
    );
  }
}
