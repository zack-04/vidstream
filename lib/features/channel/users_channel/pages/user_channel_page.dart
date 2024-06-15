import 'package:flutter/material.dart';
import 'package:vidstream/cores/widgets/flat_button.dart';
import 'package:vidstream/features/channel/users_channel/parts/user_top_header.dart';

class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool haveVideos = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const UserTopHeader(),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    'Official Account of Sony SAB',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Icon(Icons.arrow_right_outlined)
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  text: 'Subscribe',
                  onPressed: () {},
                  colour: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              haveVideos
                  ? const SizedBox()
                  : const Center(
                      child: Text(
                        'No videos',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
