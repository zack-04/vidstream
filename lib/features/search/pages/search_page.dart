import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidstream/features/auth/model/user_model.dart';
import 'package:vidstream/features/search/providers/search_provider.dart';
import 'package:vidstream/features/search/widgets/search_channel_tile.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  List foundItems = [];
  final TextEditingController controller = TextEditingController();

  Future<void> filterLists(String keywordSelected) async {
    if (keywordSelected.isEmpty) {
      setState(() {
        foundItems = [];
      });
      return;
    }
    List<UserModel> channels = await ref.watch(allChannelProvider);
    List result = [];
    final foundChannels = channels
        .where((user) =>
            user.displayName.toString().toLowerCase().contains(keywordSelected))
        .toList();

    result.addAll(foundChannels);

    setState(() {
      foundItems = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) async {
                        await filterLists(value);
                      },
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Search Vidstream',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white60
                              : Colors.black54,
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        fillColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade800
                                : const Color(0xfff2f2f2),
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: foundItems.isEmpty && controller.text.isNotEmpty
                    ? Text('No channels found')
                    : ListView.builder(
                        itemCount: foundItems.length,
                        itemBuilder: (context, index) {
                          return SearchChannelTile(
                            userModel: foundItems[index],
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
