// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String itemText;
  final VoidCallback itemClicked;
  final String imageName;
  final double imageSize;

  const ImageItem({
    super.key,
    required this.itemText,
    required this.itemClicked,
    required this.imageName,
    this.imageSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemClicked,
      child: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    color: Colors.transparent),
                child: Image.asset(
                  "assets/icons/$imageName",
                  color: Theme.of(context).iconTheme.color,
                  fit: BoxFit.cover,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    itemText,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w400,
                    ),
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
