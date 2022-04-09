import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int uid;
  final String providerId;

  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  const PersonEntity({
    required this.uid,
    required this.providerId,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  @override
  List<Object?> get props => [
        uid,
        providerId,
        displayName,
        email,
        phoneNumber,
        photoURL,
      ];

  @override
  String toString() {
    return 'PersonEntity{uid: $uid, providerId: $providerId, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL}';
  }
}
