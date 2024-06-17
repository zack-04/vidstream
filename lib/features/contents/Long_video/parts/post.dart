import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: "imageUrl")
        ],
      ),
    );
  }
}