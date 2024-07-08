// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/upload/long_video/long_video_repository.dart';
import 'package:vidstream/home_page.dart';

class LongVideoDetailsPage extends ConsumerStatefulWidget {
  final File video;
  const LongVideoDetailsPage({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<LongVideoDetailsPage> createState() =>
      _LongVideoDetailsPageState();
}

class _LongVideoDetailsPageState extends ConsumerState<LongVideoDetailsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String randomNumber = const Uuid().v4();
  String videoId = const Uuid().v4();
  File? image;
  bool isThumbnailSelected = false;
  bool isLoading = false;
  final FocusNode _descriptionFocusNode = FocusNode();
  @override
  void dispose() {
    _descriptionFocusNode.dispose(); // Dispose focus node when not needed
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
                fontSize: 23,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                color: Colors.blueGrey.shade100,
                                child: isThumbnailSelected
                                    ? Image.file(
                                        image!,
                                        height: 170,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(),
                              ),
                              Positioned(
                                right: 16,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () async {
                                    image = await pickImage();
                                    isThumbnailSelected = true;
                                    setState(() {});
                                  },
                                  child: Image.asset(
                                    "assets/icons/camera.png",
                                    height: 34,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              hintText: 'Enter title',
                              prefixIcon: Icon(Icons.title),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: descriptionController,
                            maxLines: 5,
                            focusNode: _descriptionFocusNode,
                            textInputAction:
                                TextInputAction.done, // Set text input action
                            onEditingComplete: () {
                              _descriptionFocusNode
                                  .unfocus(); // Unfocus on submit
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter the Description",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                          const Spacer(),
                          isThumbnailSelected
                              ? Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: FlatButton(
                                    text: 'Publish',
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String thumbnailUrl = await putFileInStorage(
                                          image, randomNumber, "image");
                                      String videoUrl = await putFileInStorage(
                                          widget.video, randomNumber, "video");
                                      await ref
                                          .watch(longVideoProvider)
                                          .uploadVideoToFirestore(
                                            videoUrl: videoUrl,
                                            thumbnail: thumbnailUrl,
                                            title: titleController.text,
                                            description:
                                                descriptionController.text,
                                            videoId: videoId,
                                            datePublished: DateTime.now(),
                                            userId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                          );

                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (mounted) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Video uploaded successfully',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                    color: Colors.green,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
