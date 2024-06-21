// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/upload/short_video/repository/short_video_repository.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add details',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () async {},
                          child: const FaIcon(
                            FontAwesomeIcons.pen,
                            color: Colors.white,
                            size: 15,
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
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Krishn',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '@ZacK-cr7cw',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              FlatButton(
                text: 'Publish',
                onPressed: () async {
                  await ref.watch(shortVideoProvider).addShortVideoToFireStore(
                        caption: captionController.text,
                        shortVideo: widget.video.path,
                        datePublished: date,
                      );
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                colour: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
