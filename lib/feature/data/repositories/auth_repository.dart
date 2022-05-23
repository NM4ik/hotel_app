import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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

      if (user.user != null) {
        final userModel = await locator.get<FirestoreRepository>().addUserToUserCollection(UserModel.toUser(user.user));

        if (userModel == null) {
          locator.get<SqlRepository>().userToSql(UserModel.toUser(user.user));
        } else {
          locator.get<SqlRepository>().userToSql(userModel);
        }
      }
    } catch (e) {
      log('$e', name: 'Exception by singInWithGoogle');
      return null;
    }
  }

  void logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      locator.get<SqlRepository>().userToSql(UserModel.empty);
    } catch (e) {
      log('$e', name: 'Exception by logout');
    }
  }

  Future<void> setUpAccount(String uid, String email, String name) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({'email': email, 'name': name});
    final userModel = await locator.get<FirestoreRepository>().getUserFromUserCollection(uid);
    locator.get<SqlRepository>().userToSql(userModel);
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      uid: uid,
      email: email,
      name: displayName,
      phoneNumber: phoneNumber,
    );
  }
}
