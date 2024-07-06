import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/channel/my_channel/parts/my_channel_video_tab_page.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';

class VideoChannelPage extends StatelessWidget {
  const VideoChannelPage({super.key});

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
                            child: Text(
                              'No videos',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            if (videos.isNotEmpty) {
                              return MyChannelVideoTabPage(
                                video: videos[index],
                              );
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
