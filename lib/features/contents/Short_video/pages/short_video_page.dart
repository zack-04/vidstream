import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vidstream/cores/screens/error_page.dart';
import 'package:vidstream/cores/screens/loader.dart';
import 'package:vidstream/features/contents/Short_video/widgets/short_video_tile.dart';
import 'package:vidstream/features/upload/short_video/model/short_video_model.dart';

class ShortVideoPage extends StatelessWidget {
  const ShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('shorts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) {
              return const ErrorPage();
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Loader();
            }
            return PageView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final shortVideoMaps = snapshot.data!.docs;
                final shortVideoModel =
                    ShortVideoModel.fromMap(shortVideoMaps[index].data());
                return ShortVideoTile(shortVideoModel: shortVideoModel);
              },
            );
          },
        ),
      ),
    );
  }
}