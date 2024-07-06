import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/channel/my_channel/parts/shorts_container.dart';
import 'package:vidstream/features/channel/users_channel/provider/channel_provider.dart';

class ShortsChannelPage extends StatelessWidget {
  const ShortsChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref
              .watch(eachChannelShortsVideosProvider(
                  FirebaseAuth.instance.currentUser!.uid))
              .when(
                data: (shorts) {
                  return shorts.isEmpty
                      ? Center(
                          child: Text('No shorts'),
                        )
                      : GridView.builder(
                          itemCount: shorts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return ShortsContainer(
                              shortVideoModel: shorts[index],
                            );
                          },
                        );
                },
                error: (error, stackTrace) => const ErrorPage(),
                loading: () => const Loader(),
              );
        },
      ),
    );
  }
}
