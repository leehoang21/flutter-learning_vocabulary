import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
part 'user_model.g.dart';

@collection
class UserModel {
  final String userName;
  final String? email;
  final String? avatar;
  Id? id;
  final String _uid;

  UserModel({
    String uid = '',
    this.userName = '',
    this.email,
    this.avatar,
  }) : _uid = uid;

  String get uid => _uid;

  UserModel copyWith({
    String? userName,
    String? email,
    String? avatar,
  }) {
    return UserModel(
      uid: _uid,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserModel.fromDocument(DocumentSnapshot snapshot, String id) {
    if (snapshot.data() == null) {
      throw Exception;
    }
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: id,
      userName: data['userName'] as String,
      email: data['email'] as String?,
      avatar: data['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'avatar': avatar,
      'email': email,
    };
  }
}
