// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
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
  String randomNumber = const Uuid().v4();
  bool isLoading = false;
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: double.infinity,
                    child: FlatButton(
                      text: 'Publish',
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String videoUrl = await putFileInStorage(
                            widget.video, randomNumber, "shorts");
                        await ref
                            .watch(shortVideoProvider)
                            .addShortVideoToFireStore(
                              caption: captionController.text,
                              shortVideo: videoUrl,
                              datePublished: date,
                            );
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      colour: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
