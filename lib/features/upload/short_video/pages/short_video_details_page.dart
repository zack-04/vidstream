// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/visibility.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/upload/short_video/repository/short_video_repository.dart';
import 'package:vidstream/features/upload/short_video/widgets/custom_elevated_button.dart';
import 'package:vidstream/home_page.dart';

class ShortVideoDetailPage extends ConsumerStatefulWidget {
  final File video;
  const ShortVideoDetailPage({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<ShortVideoDetailPage> createState() =>
      _ShortVideoDetailPageState();
}

class _ShortVideoDetailPageState extends ConsumerState<ShortVideoDetailPage> {
  final TextEditingController captionController = TextEditingController();
  final DateTime date = DateTime.now();
  String randomNumber = const Uuid().v4();
  bool isLoading = false;
  FlickManager? flickManager;
  late VideoPlayerController videoPlayerController;
  String videoDuration = '';

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.video);

    videoPlayerController.initialize().then((_) {
      setState(() {
        videoDuration = _formatDuration(videoPlayerController.value.duration);
      });
    });
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  Future<void> uploadShortVideo(BuildContext context) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    String videoUrl =
        await putFileInStorage(widget.video, randomNumber, "shorts");
    await ref.watch(shortVideoProvider).addShortVideoToFireStore(
          caption: captionController.text,
          shortVideo: videoUrl,
          datePublished: date,
        );
    setState(() {
      isLoading = true;
    });

    Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Short uploaded successfully',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green,
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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add details',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 120,
                              width: 100,
                              child: FlickVideoPlayer(
                                flickManager: flickManager!,
                                flickVideoWithControls:
                                    const FlickVideoWithControls(
                                  videoFit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: IconButton(
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 5,
                              ),
                              child: Text(
                                videoDuration,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: captionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Caption your Short',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 20,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ref.watch(currentUserProvider).when(
                        data: (currentUser) {
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 25,
                                backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentUser.displayName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '@${currentUser.userName}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const Loader(),
                      ),
                  const Spacer(),
                  CustomElevatedButton(
                    text: 'Upload Short',
                    onPressed: () async {
                      uploadShortVideo(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        VisibilityLoader(visible: isLoading),
      ],
    );
  }
}
