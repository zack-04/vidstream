// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/contents/comment/comment_tile.dart';
import 'package:vidstream/features/upload/comments/comment_model.dart';
import 'package:vidstream/features/upload/comments/comment_repository.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final LongVideoModel video;
  const CommentSheet({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData((user) => user);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Divider(
              color: Colors.grey.shade400,
              thickness: 1.5,
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.35,
          //   child: const Center(
          //     child: Text("No comments yet."),
          //   ),
          // ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .where('videoId', isEqualTo: widget.video.videoId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              final commentMap = snapshot.data!.docs;
              final comments = commentMap
                  .map((comment) => CommentModel.fromMap(comment.data()))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(
                      comment: comments[index],
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(
            child: Divider(
              color: Colors.grey,
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      CachedNetworkImageProvider(user.value!.profilePic),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                IconButton(
                  onPressed: () async {
                    await ref.watch(commentProvider).uploadCommentToFirestore(
                          commentText: commentController.text,
                          videoId: widget.video.videoId,
                          userName: user.value!.userName,
                          profilePic: user.value!.profilePic,
                          datePublished: DateTime.now(),
                        );
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
