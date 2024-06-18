import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';
import 'package:vidstream/features/upload/long_video/video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const ErrorPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          final videoMap = snapshot.data!.docs;
          final videos = videoMap.map((video) {
            return VideoModel.fromMap(video.data());
          }).toList();

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Post(
                  video: videos[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
