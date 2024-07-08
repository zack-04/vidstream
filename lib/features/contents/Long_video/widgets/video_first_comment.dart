// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/upload/comments/comment_model.dart';

class VideoFirstComment extends StatelessWidget {
  final List<CommentModel> comments;
  final UserModel user;
  const VideoFirstComment({
    super.key,
    required this.comments,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "${comments.length}",
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7.5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    user.profilePic,
                  ),
                ),
                const SizedBox(width: 7),
                SizedBox(
                  width: 280,
                  child: Text(
                    comments[0].commentText,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
