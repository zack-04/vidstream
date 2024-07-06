import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';
import 'package:vidstream/features/upload/upload_bottom_sheet.dart';

class HomeChannelPage extends StatelessWidget {
  const HomeChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(eachChannelVideosProvider(
                  FirebaseAuth.instance.currentUser!.uid))
              .when(
                data: (videos) {
                  return videos.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.amber,
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Create content on any device',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Upload and record at home or on the go. \nEverything that you make public will appear here.',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor:
                                          (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.black.withOpacity(0.95)
                                              : Colors.white),
                                      context: context,
                                      builder: (context) =>
                                          const CreateBottomSheet(),
                                    );
                                  },
                                  child: Text(
                                    'Create',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            if (videos.isNotEmpty) {
                              return Post(video: videos[index]);
                            }
                            return const SizedBox();
                          },
                        );
                },
                error: (error, stackTrace) => const ErrorPage(),
                loading: () => const Loader(),
              );
        },
      ),
    );
  }
}
