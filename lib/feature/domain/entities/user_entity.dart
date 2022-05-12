import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;

  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final bool? isNotifications;

  const UserEntity({
    required this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.isNotifications,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
        photoURL,
        isNotifications,
      ];

  @override
  String toString() {
    return 'PersonEntity{uid: $uid, displayName: $name, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, isNotifications: $isNotifications}';
  }
}
