import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LongVideoModel {
  final String videoUrl;
  final String thumbnail;
  final String title;
  final String description;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final List likes;
  final String type;
  LongVideoModel({
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'title': title,
      'description':description,
      'datePublished': datePublished,
      'views': views,
      'videoId': videoId,
      'userId': userId,
      'likes': likes,
      'type': type,
    };
  }

  factory LongVideoModel.fromMap(Map<String, dynamic> map) {
    return LongVideoModel(
      videoUrl: map['videoUrl'] as String,
      thumbnail: map['thumbnail'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      datePublished: map["datePublished"] is Timestamp
          ? (map["datePublished"] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(
              map["datepublished"] as int,
            ),
      views: map['views'] as int,
      videoId: map['videoId'] as String,
      userId: map['userId'] as String,
      likes: List.from(
        (map['likes'] as List),
      ),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LongVideoModel.fromJson(String source) =>
      LongVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
