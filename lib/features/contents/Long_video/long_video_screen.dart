import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/image_button.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';
import 'package:vidstream/features/search/pages/search_page.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo4.png',
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade400
                      : Colors.grey.shade800,
                ),
                const Text(
                  'Vidstream',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(width: 4),
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: ImageButton(
                    image: "cast.png",
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 48,
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
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('videos').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                } else if (snapshot.hasError) {
                  return const ErrorPage();
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    child: Center(
                      child: Text(
                        'No videos...',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                } else {
                  final videoMap = snapshot.data!.docs;
                  final videos = videoMap.map((video) {
                    return LongVideoModel.fromMap(video.data());
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
