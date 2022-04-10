import '../../domain/entities/user_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends PersonEntity{
  const UserModel({required String uid, String? providerId, String? displayName, String? email, String? phoneNumber, String? photoURL})
      : super(uid: uid, providerId: providerId, displayName: displayName, email: email, phoneNumber: phoneNumber, photoURL: photoURL);

  static const empty = UserModel(uid: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{}';
  }
}