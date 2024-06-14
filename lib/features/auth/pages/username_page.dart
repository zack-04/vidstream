// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vidstream/features/auth/repository/user_data_service.dart';

class UserNamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String profilePic;
  final String email;
  const UserNamePage({
    super.key,
    required this.displayName,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends ConsumerState<UserNamePage> {
  final TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isValidate = true;

  void validateUsername() async {
    final userMap = await FirebaseFirestore.instance.collection('Users').get();
    final users = userMap.docs.map((e) => e).toList();
    String? targetedUsername;
    for (var user in users) {
      if (userNameController.text == user.data()['userName']) {
        targetedUsername = user.data()['userName'];
        isValidate = false;
        setState(() {});
      }
      if (userNameController.text != targetedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                'USERNAME PAGE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        validateUsername();
                      },
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        return isValidate ? null : "Username already taken";
                      },
                      controller: userNameController,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        label: const Text('Enter username'),
                        labelStyle: const TextStyle(color: Colors.black54),
                        suffixIcon: isValidate
                            ? const Icon(Icons.verified_user_rounded)
                            : const Icon(Icons.cancel),
                        suffixIconColor: isValidate ? Colors.green : Colors.red,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () async {
                  isValidate
                      ? await ref
                          .read(userDataServiceProvider)
                          .addUserDataToFirestore(
                            displayName: widget.displayName,
                            userName: userNameController.text,
                            email: widget.email,
                            profilePic: widget.profilePic,
                            description: "",
                          )
                      : null;
                },
                color: isValidate ? Colors.green : Colors.green.shade100,
                height: 50,
                minWidth: double.infinity,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
