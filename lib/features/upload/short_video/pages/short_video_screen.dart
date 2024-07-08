// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/video_editor.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/upload/short_video/pages/short_video_details_page.dart';
import 'package:vidstream/features/upload/short_video/widgets/trim_slider.dart';

class ShortVideoScreen extends StatefulWidget {
  final File shortVideo;
  const ShortVideoScreen({
    super.key,
    required this.shortVideo,
  });

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  VideoEditorController? _controller;
  final isExporting = ValueNotifier<bool>(false);
  final exportingProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _controller = VideoEditorController.file(
      widget.shortVideo,
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(seconds: 60),
    );
    _controller!.initialize().then((_) => setState(() {}));
  }

  Future<void> exportVideo() async {
    isExporting.value = true;
    final config = VideoFFmpegVideoEditorConfig(_controller!);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    FFmpegKit.executeAsync(
      command,
      (session) async {
        final ReturnCode? code = await session.getReturnCode();
        if (ReturnCode.isSuccess(code)) {
          //export video
          isExporting.value = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShortVideoDetailPage(
                video: widget.shortVideo,
              ),
            ),
          );
        } else {
          //show error
          showErrorSnackBar('Failed cannot be exported !', context);
        }
      },
      null,
      (statistics) {
        exportingProgress.value =
            config.getFFmpegProgress(statistics.getTime().toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _controller!.initialized
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(currentUserProvider).when(
                                  data: (currentUser) {
                                    return CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        currentUser!.profilePic,
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) =>
                                      const ErrorPage(),
                                  loading: () => const Loader(),
                                );
                          },
                        )
                      ],
                    ),
                    const Spacer(),
                    CropGridViewer.preview(controller: _controller!),
                    const Spacer(),
                    MyTrimSlider(
                      controller: _controller!,
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          minWidth: 20,
                          color: Colors.white,
                          textColor: Colors.black,
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: exportVideo,
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
