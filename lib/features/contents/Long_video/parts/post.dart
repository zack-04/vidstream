import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/upload/long_video/video_model.dart';

class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel = ref.watch(
      anyDataUserProvider(video.userId),
    );
    final user = userModel.whenData((user) => user);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
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
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(user.value!.profilePic),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
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
                                user.value!.displayName,
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                video.views == 0
                                    ? 'No views'
                                    : '${video.views.toString()} views',
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'a moment ago',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ],
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
