// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountItem extends ConsumerWidget {
  final String itemText;
  final GestureTapCallback itemClicked;
  final FaIcon icon;
  

  const AccountItem({
    super.key,
    required this.itemText,
    required this.itemClicked,
    required this.icon,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: itemClicked,
      child: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: ListTile(
          title: Text(
            itemText,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: icon,
          
        ),
      ),
    );
  }
}
