import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({required String uid, String? name, String? email, String? phoneNumber, bool? isNotifications})
      : super(uid: uid, name: name, email: email, phoneNumber: phoneNumber, isNotifications: isNotifications);

  static const empty = UserModel(uid: '', isNotifications: false);

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.toUser(User? user) {
    if (user == null) {
      return UserModel.empty;
    } else {
      return UserModel(
        uid: user.uid,
        email: user.email,
        name: user.displayName,
        phoneNumber: user.phoneNumber,
      );
    }
  }
}
