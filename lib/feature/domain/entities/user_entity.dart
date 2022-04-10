import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final String uid;

  final String? providerId;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;

  const PersonEntity({
    required this.uid,
    this.providerId,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
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
