// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/upload/long_video/video_repository.dart';
import 'package:vidstream/home_page.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File video;
  const VideoDetailsPage({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String randomNumber = const Uuid().v4();
  String videoId = const Uuid().v4();
  File? image;
  bool isThumbnailSelected = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Add details',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 106, 105, 105),
          ),
        ),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
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
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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
      ),
      bottomNavigationBar: isThumbnailSelected
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: FlatButton(
                text: 'Publish',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String thumbnail =
                      await putFileInStorage(image, randomNumber, "image");
                  String videoUrl = await putFileInStorage(
                      widget.video, randomNumber, "video");
                  ref.watch(longVideoProvider).uploadVideoToFirestore(
                        videoUrl: videoUrl,
                        thumbnail: thumbnail,
                        title: titleController.text,
                        description: descriptionController.text,
                        videoId: videoId,
                        datePublished: DateTime.now(),
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      );
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                colour: Colors.green,
              ),
            )
          : const SizedBox(),
    );
  }
}
