// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';
import 'package:vidstream/features/contents/Long_video/widgets/video_extra_button.dart';
import 'package:vidstream/features/contents/Long_video/widgets/video_first_comment.dart';
import 'package:vidstream/features/contents/comment/comment_provider.dart';
import 'package:vidstream/features/contents/comment/comment_sheet.dart';
import 'package:vidstream/features/upload/comments/comment_model.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';
import 'package:vidstream/features/upload/long_video/long_video_repository.dart';

class Video extends ConsumerStatefulWidget {
  final LongVideoModel video;
  const Video({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  bool isShowIcons = false;
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.video.videoUrl),
      ),
    );
  }

  Future<void> likeVideo() async {
    await ref.watch(longVideoProvider).likeVideo(
          currentUserId: FirebaseAuth.instance.currentUser!.uid,
          likes: widget.video.likes,
          videoId: widget.video.videoId,
        );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user = ref.watch(
      anyDataUserProvider(widget.video.userId),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(176),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isShowIcons = !isShowIcons;
              });
            },
            child: Stack(
              children: [
                FlickVideoPlayer(flickManager: flickManager!),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          widget.video.views == 0
                              ? "No view"
                              : "${widget.video.views} views",
                          style: const TextStyle(
                            fontSize: 13.4,
                            color: Color(0xff5F5F5F),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        timeago.format(widget.video.datePublished),
                        style: const TextStyle(
                          fontSize: 13.4,
                          color: Color(0xff5F5F5F),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                          user.value!.profilePic,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 5,
                        ),
                        child: Text(
                          user.value!.displayName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6, left: 6),
                        child: Text(
                          user.value!.subscriptions.isEmpty
                              ? "No subs"
                              : "${user.value!.subscriptions.length} subs",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: FlatButton(
                            text: "Subscribe",
                            onPressed: () async {
                              // subscribe channel
                              // await ref
                              //     .watch(subscribeChannelProvider)
                              //     .subscribeChannel(
                              //       userId: user.value!.userId,
                              //       currentUserId:
                              //           FirebaseAuth.instance.currentUser!.uid,
                              //       subscriptions: user.value!.subscriptions,
                              //     );
                            },
                            colour: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, top: 15, right: 9),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('videos')
                                .doc(widget.video.videoId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Loader();
                              }
                              var videoData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              var likes =
                                  List<String>.from(videoData['likes'] ?? []);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 6,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 237, 236, 236),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await likeVideo();
                                      },
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: likes.contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            ? Colors.blue
                                            : Colors.black,
                                        size: 15.5,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Text("${likes.length}"),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        color: Colors.black,
                                        thickness: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.thumb_down,
                                      size: 15.5,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 9, right: 9),
                            child: VideoExtraButton(
                              text: "Share",
                              iconData: Icons.share,
                            ),
                          ),
                          const VideoExtraButton(
                            text: "Remix",
                            iconData: Icons.analytics_outlined,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 9,
                              right: 9,
                            ),
                            child: VideoExtraButton(
                              text: "Download",
                              iconData: Icons.download,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // comment Box

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => CommentSheet(
                      video: widget.video,
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final AsyncValue<List<CommentModel>> comments = ref.watch(
                        commentsProvider(widget.video.videoId),
                      );
                      if (comments.value == null || comments.value!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: const SizedBox(
                            height: 20,
                            child: Text(
                              "No comments...",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }

                      return VideoFirstComment(
                        comments: comments.value!,
                        user: user.value!,
                      );
                    },
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("videos")
                  .where("videoId", isNotEqualTo: widget.video.videoId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return ErrorPage();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Loader();
                }

                final videosMap = snapshot.data!.docs;
                final videos = videosMap
                    .map(
                      (video) => LongVideoModel.fromMap(video.data()),
                    )
                    .toList();
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return Post(
                      video: videos[index],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
