// class Channel {
//   final String id;
//   final String name;
//   final String profilePicUrl;

//   Channel({
//     required this.id,
//     required this.name,
//     required this.profilePicUrl,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'profilePicUrl': profilePicUrl,
//     };
//   }

//   factory Channel.fromMap(Map<String, dynamic> map) {
//     return Channel(
//       id: map['id'],
//       name: map['name'],
//       profilePicUrl: map['profilePicUrl'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Channel {
  final String id;
  final String name;
  final String profilePic;

  Channel({required this.id, required this.name, required this.profilePic});

  factory Channel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Channel(
      id: doc.id,
      name: data['name'] ?? '',
      profilePic: data['profilePic'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'profilePic': profilePic,
    };
  }
}

