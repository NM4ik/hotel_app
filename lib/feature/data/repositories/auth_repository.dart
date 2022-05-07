import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';
import 'package:hotel_ma/feature/data/repositories/sql_repository.dart';

import '../../../core/locator_service.dart';
import '../datasources/sql_methods.dart';
import '../models/user_model.dart';

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  dynamic currentUser = UserModel.empty;

  Stream<UserModel> get userModel {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final userModel = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      currentUser = userModel;
      return userModel;
    });
  }

  void singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final user = await _firebaseAuth.signInWithCredential(credential);
      locator.get<SqlRepository>().userToSql(UserModel.toUser(user.user));
      locator.get<FirestoreRepository>().personToUserCollection(UserModel.toUser(user.user));
    } catch (e) {
      log('$e', name: 'Exception by singInWithGoogle');
      return null;
    }
  }

  // Future<void> verifyNumber(
  //   String phone, {
  //   void Function(firebase_auth.PhoneAuthCredential)? completed,
  //   void Function(firebase_auth.FirebaseAuthException)? failed,
  //   void Function(String, int?)? codeSent,
  //   void Function(String)? timeout,
  // }) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phone, verificationCompleted: completed!, verificationFailed: failed!, codeSent: codeSent!, codeAutoRetrievalTimeout: timeout!);
  // }
  //
  // Future<void> verifyAndLogin(String verificationId, String smsCode, String phone) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //   final user = await _firebaseAuth.signInWithCredential(credential);
  //   locator.get<FirestoreRepository>().personToUserCollection(UserModel.toUser(user.user));
  // }

  // Future<void> verifyNumber(String phoneNumber) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _firebaseAuth.signInWithCredential(credential).then((value) => print('Logged IN!'));
  //       },
  //       verificationFailed: (FirebaseAuthException exception) {
  //         if (exception.code == 'invalid-phone-number') {
  //           print('The provided phone number is not valid.');
  //         } else {
  //           print(exception.message);
  //         }
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {}
  //   );
  // }

  // void verifyCode(String verificationId, String smsCode) async {
  //   print("$verificationId IDID@@");
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //   final user = await _firebaseAuth.signInWithCredential(credential);
  //   locator.get<FirestoreRepository>().personToUserCollection(UserModel.toUser(user.user));
  // }

  void logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      log('$e', name: 'Exception by logout');
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(uid: uid, email: email, displayName: displayName, phoneNumber: phoneNumber, photoURL: photoURL);
  }
}
