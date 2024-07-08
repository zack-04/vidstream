import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vidstream/cores/methods.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/cores/utils/constants.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/my_channel/repository/edit_field.dart';
import 'package:vidstream/features/channel/my_channel/widgets/edit_setting_dialog.dart';
import 'package:vidstream/features/channel/my_channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;

  String randomNumber = const Uuid().v4();

  void refreshUser() {
    return ref.refresh(currentUserProvider);
  }

  Future<void> uploadBanner(File image) async {
    String coverImageUrl = await putFileInStorage(image, randomNumber, "image");
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'coverImageUrl': coverImageUrl,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cover image uploaded',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 15, 232, 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              currentUser!.coverImageUrl.isNotEmpty
                                  ? currentUser.coverImageUrl
                                  : DEFAULT_BANNER,
                            ), // Background image
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic,
                                ),
                              ),
                            ),
                            // Top Right Icon
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  File image = await pickImage();
                                  await uploadBanner(image);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Stack(
                      //   children: [
                      //     Container(
                      //       height: 130,
                      //       width: double.infinity,
                      //       color: Colors.blue,
                      //     ),
                      //     Align(
                      //       alignment: Alignment.center,
                      //       child: CircleAvatar(
                      //         radius: 30,
                      //         backgroundColor: Colors.grey,
                      //         backgroundImage: CachedNetworkImageProvider(
                      //           currentUser.profilePic,
                      //         ),
                      //       ),
                      //     ),
                      //     Positioned(
                      //       right: 16,
                      //       top: 10,
                      //       child: Image.asset(
                      //         "assets/icons/camera.png",
                      //         height: 34,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // second part

                      const SizedBox(height: 14),

                      SettingsItem(
                        identifier: "Name",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "DisplayName",
                              onSave: (displayName) async {
                                await ref
                                    .watch(editSettingsProvider)
                                    .editDisplayName(displayName);
                                refreshUser();
                              },
                            ),
                          );
                        },
                        value: currentUser.displayName,
                      ),
                      const SizedBox(height: 14),
                      SettingsItem(
                        identifier: "Handle",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "UserName",
                              onSave: (userName) async {
                                await ref
                                    .watch(editSettingsProvider)
                                    .editUserName(userName);
                                refreshUser();
                              },
                            ),
                          );
                        },
                        value: currentUser.userName,
                      ),
                      const SizedBox(height: 14),
                      SettingsItem(
                        identifier: "Description",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => SettingsDialog(
                              identifier: "Description",
                              onSave: (description) async {
                                await ref
                                    .watch(editSettingsProvider)
                                    .editDescription(description);
                                refreshUser();
                              },
                            ),
                          );
                        },
                        value: currentUser.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Keep all my subscribers private",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                isSwitched = value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Text(
                          "Changes made on your names and profile pictures are visible only to vidstream.",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
