import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/contents/Long_video/parts/video.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

class Post extends ConsumerWidget {
  final LongVideoModel video;
  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel = ref.watch(
      anyDataUserProvider(video.userId),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Video(video: video),
          ),
        );
      },
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: video.thumbnail,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            // color: Colors.grey.shade300,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userModel.when(
                        data: (user) {
                          return CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                CachedNetworkImageProvider(user.profilePic),
                          );
                        },
                        loading: () => const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey,
                        ),
                        error: (_, __) => const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      userModel.when(
                        data: (user) {
                          String timeAgo = timeago.format(video.datePublished);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.displayName,
                                    style:
                                        const TextStyle(color: Colors.blueGrey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    video.views == 0
                                        ? 'No views'
                                        : '${video.views.toString()} views',
                                    style:
                                        const TextStyle(color: Colors.blueGrey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    timeAgo,
                                    style:
                                        const TextStyle(color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        loading: () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const CircularProgressIndicator(),
                          ],
                        ),
                        error: (_, __) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'Error loading user',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
