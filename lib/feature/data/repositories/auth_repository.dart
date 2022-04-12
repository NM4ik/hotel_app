import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';

import '../../../core/locator_service.dart';
import '../datasources/shared_preferences_methods.dart';
import '../models/user_model.dart';

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final PersonStatus personStatus = PersonStatus(sharedPreferences: locator());


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
      personStatus.writePersonToCache(userModel);
      return userModel;
    });
  }

  Future<UserCredential?> singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Exception by singInWithGoogle $e');
      return null;
    }
  }

  void logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print(currentUser);
    } catch (e) {
      print('Exception by logout $e');
    }
  }

  bool authStatus() {
    final status = PersonStatus(sharedPreferences: locator());
    return status.getAuthStatus();
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(uid: uid, email: email, displayName: displayName, phoneNumber: phoneNumber, photoURL: photoURL);
  }
}
