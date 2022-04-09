import '../../domain/entities/user_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends PersonEntity {
  const UserModel(
      {required int uid,
      required String providerId,
      required String? displayName,
      required String? email,
      required String? phoneNumber,
      required String? photoURL})
      : super(uid: uid, providerId: providerId, displayName: displayName, email: email, phoneNumber: phoneNumber, photoURL: photoURL);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
