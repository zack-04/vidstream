// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String displayName;
  final String userName;
  final String email;
  final String profilePic;
  final String coverImageUrl;
  final List<String> subscribedChannels;
  final List<String> subscribers;
  final String userId;
  final String description;
  final String type;
  UserModel({
    required this.displayName,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.coverImageUrl,
    required this.subscribedChannels,
    required this.subscribers,
    required this.userId,
    required this.description,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'userName': userName,
      'email': email,
      'profilePic': profilePic,
      'coverImageUrl': coverImageUrl,
      'subscribedChannels': subscribedChannels,
      'subscribers': subscribers,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      coverImageUrl: map['coverImageUrl'] as String,
      subscribedChannels: List<String>.from(map['subscribedChannels'] ?? []),
      subscribers: List<String>.from(map['subscribers'] ?? []),
      userId: map['userId'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
    );
  }
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      userId: doc.id,
      displayName: doc['displayName'],
      profilePic: doc['profilePic'],
      coverImageUrl: doc['coverImageUrl'],
      description: doc['description'],
      subscribedChannels: List<String>.from(doc['subscribedChannels'] ?? []),
      subscribers: List<String>.from(doc['subscribers'] ?? []),
      userName: doc['userName'],
      email: doc['email'],
      type: doc['type'],
    );
  }
}
