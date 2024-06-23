import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';

class HomeChannelPage extends StatelessWidget {
  const HomeChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(eachChannelVideosprovider(
                  FirebaseAuth.instance.currentUser!.uid))
              .when(
                data: (videos) {
                  return videos.isEmpty
                      ? const Center(
                          child: Text('No video'),
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
