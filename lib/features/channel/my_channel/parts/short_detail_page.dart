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

class MyChannelShortDetailPage extends ConsumerStatefulWidget {
  final ShortVideoModel shortVideoModel;
  const MyChannelShortDetailPage({
    super.key,
    required this.shortVideoModel,
  });

  @override
  ConsumerState<MyChannelShortDetailPage> createState() =>
      _MyChannelShortDetailPageState();
}

class _MyChannelShortDetailPageState
    extends ConsumerState<MyChannelShortDetailPage> {
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.shortVideoModel.shortVideo),
      ),
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<UserModel> user = ref.watch(
      anyDataUserProvider(widget.shortVideoModel.userId),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 11 / 17.5,
                  child: FlickVideoPlayer(flickManager: flickManager!),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
