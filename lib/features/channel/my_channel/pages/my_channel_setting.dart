import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/auth/provider/user_provider.dart';
import 'package:vidstream/features/channel/my_channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;
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
                      Stack(
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            color: Colors.blue,
                          ),
                          Positioned(
                            left: 180,
                            top: 60,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  currentUser.profilePic),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 10,
                            child: Image.asset(
                              "assets/icons/camera.png",
                              height: 34,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // second part

                      const SizedBox(height: 14),

                      SettingsItem(
                        identifier: "Name",
                        onPressed: () {},
                        value: currentUser.displayName,
                      ),
                      const SizedBox(height: 14),
                      SettingsItem(
                        identifier: "Handle",
                        onPressed: () {},
                        value: currentUser.userName,
                      ),
                      const SizedBox(height: 14),
                      SettingsItem(
                        identifier: "Description",
                        onPressed: () {},
                        value: currentUser.description,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Keep all my subscribers private"),
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
                          "Changes made on your names and profile pictures are visible only to youtube and not other Google Services",
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
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
