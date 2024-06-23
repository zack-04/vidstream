// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/upload/short_video/model/short_video_model.dart';

class ShortVideoTile extends ConsumerStatefulWidget {
  final ShortVideoModel shortVideoModel;
  const ShortVideoTile({
    super.key,
    required this.shortVideoModel,
  });

  @override
  ConsumerState<ShortVideoTile> createState() => _ShortVideoTileState();
}

class _ShortVideoTileState extends ConsumerState<ShortVideoTile> {
  FlickManager? flickManager;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.shortVideoModel.shortVideo),
      ),
    );
    flickManager!.flickVideoManager!.videoPlayerController!
        .addListener(_videoListener);
  }

  void _videoListener() {
    if (!mounted) return;
    final isPlaying =
        flickManager!.flickVideoManager!.videoPlayerController!.value.isPlaying;
    if (isPlaying != this.isPlaying) {
      setState(() {
        this.isPlaying = isPlaying;
      });
    }
  }

  @override
  void dispose() {
    flickManager!.flickVideoManager!.videoPlayerController!
        .removeListener(_videoListener);
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user = ref.watch(
      anyDataUserProvider(widget.shortVideoModel.userId),
    );
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 11 / 16,
              child: FlickVideoPlayer(flickManager: flickManager!),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              child: user.when(
                data: (user) => Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(user.profilePic),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.userName,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                loading: () => const Loader(),
                error: (err, stack) => const ErrorPage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.shortVideoModel.caption,
                style: const TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        if (!isPlaying)
          const Positioned(
            left: 10,
            top: 10,
            child: Text(
              'Shorts',
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
