import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/contents/Long_video/parts/post.dart';
import 'package:vidstream/features/search/providers/search_provider.dart';
import 'package:vidstream/features/search/widgets/search_channel_tile.dart';
import 'package:vidstream/features/upload/long_video/long_video_model.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  List foundItems = [];

  Future<void> filterLists(String keywordSelected) async {
    if (keywordSelected.isEmpty) {
      setState(() {
        foundItems = [];
      });
      return;
    }
    List<UserModel> users = await ref.watch(allChannelProvider);
    List<LongVideoModel> videos = await ref.watch(allVideosProvider);
    List result = [];
    final foundChannels = users
        .where((user) =>
            user.displayName.toString().toLowerCase().contains(keywordSelected))
        .toList();

    result.addAll(foundChannels);
    final foundVideos = videos
        .where((video) =>
            video.title.toString().toLowerCase().contains(keywordSelected))
        .toList();
    result.addAll(foundVideos);

    setState(() {
      result.shuffle();
      foundItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade700,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) async {
                      await filterLists(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search youtube...',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      fillColor: const Color(0xfff2f2f2),
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundItems.length,
                itemBuilder: (context, index) {
                  List<Widget> itemsWidgets = [];
                  final selectedItem = foundItems[index];

                  if (selectedItem.type == 'video') {
                    itemsWidgets.add(
                      Post(video: selectedItem),
                    );
                  }
                  if (selectedItem.type == 'user') {
                    itemsWidgets.add(
                      SearchChannelTile(
                        user: selectedItem,
                      ),
                    );
                  }
                  if (foundItems.isEmpty) {
                    return const SizedBox();
                  }
                  return itemsWidgets[0];
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
