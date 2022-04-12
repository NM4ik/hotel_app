import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/message_model.dart';

import '../models/user_model.dart';
import '../models/visit_model.dart';

class FirestoreData {
  final messageCollection = 'messages';

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  /// adding a first-auth users to firebase
  void addUserToCollection(UserModel? userModel) async {
    try {
      final dataExists = await users.doc(userModel!.uid).get();

      if (dataExists.exists) {
        log('user already added', name: "UserToFireBase");
        return null;
      } else {
        users.doc(userModel.uid).set({
          "email": userModel.email,
          "name": userModel.displayName,
          "phone": userModel.phoneNumber,
          "photoUrl": userModel.photoURL,
        });
        log('user was added', name: "UserToFireBase");
      }
    } catch (e) {
      print('Error from _addUserToCollection - $e');
    }
  }


  /// send user message to firebase
  /// chatRoom id(docId) = UserCredentials_uid(UserModel_uid)

  /// change String name to uid!!!!
  void sendMessage(String content, String docId, String name) {
    print('hello');
    print(content);
    DateTime dateTime = DateTime.now();
    final message = MessageModel(content: content, sendAt: dateTime, sendBy: name);
    print(message);
    chats.doc('user-uid').collection(messageCollection).add(message.toJson());
  }


  /// get a visits by user from firebase
  Future<dynamic> getVisitsByUser(String uid) async {
    try {
      List<VisitModel> visits = [];
      QuerySnapshot querySnapshot = await users.doc(uid).collection('visits').get();
      return querySnapshot;
    } catch (e) {
      print('Exception by getVisitsByUser $e');
    }
  }
}
