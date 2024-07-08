import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vidstream/features/contents/Long_video/parts/video.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

class MyChannelVideoTabPage extends StatelessWidget {
  final LongVideoModel video;
  const MyChannelVideoTabPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    String timeAgo = timeago.format(video.datePublished);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Video(video: video),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: video.thumbnail,
                fit: BoxFit.cover,
                height: 100,
              ),
            ),
          ),
          SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Row(
                  children: [
                    Text('${video.views} views '),
                    SizedBox(width: 7),
                    Text(timeAgo),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
