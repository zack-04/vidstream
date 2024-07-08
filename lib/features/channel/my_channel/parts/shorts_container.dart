import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:vidstream/features/channel/my_channel/parts/short_detail_page.dart';
import 'package:vidstream/features/upload/short_video/model/short_video_model.dart';

class ShortsContainer extends StatefulWidget {
  final ShortVideoModel shortVideoModel;
  const ShortsContainer({super.key, required this.shortVideoModel});

  @override
  State<ShortsContainer> createState() => _ShortsContainerState();
}

class _ShortsContainerState extends State<ShortsContainer> {
  File? thumbnailFile;

  @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  Future<File?> getVideoThumbnail(String videoUrl) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 150,
      quality: 75,
    );

    if (thumbnailPath != null) {
      return File(thumbnailPath);
    } else {
      return null;
    }
  }

  Future<void> generateThumbnail() async {
    thumbnailFile = await getVideoThumbnail(widget.shortVideoModel.shortVideo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyChannelShortDetailPage(shortVideoModel: widget.shortVideoModel),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 11 / 11,
          child: thumbnailFile != null
              ? Image.file(
                  thumbnailFile!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
