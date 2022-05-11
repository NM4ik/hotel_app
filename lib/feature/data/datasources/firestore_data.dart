import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/data/models/chat_model.dart';
import 'package:hotel_ma/feature/data/models/message_model.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';

import '../models/user_model.dart';

class FirestoreData {
  final messageCollection = 'messages';
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  /// adding a first-auth users to firebase
  void addUserToCollection(UserModel? userModel) async {
    try {
      final dataExists = await users.doc(userModel!.uid).get();

      if (dataExists.exists) {
        log('user already added', name: "UserToFireBase");
        return null;
      } else {
        users.doc(userModel.uid).set({
          "uid": userModel.uid,
          "email": userModel.email,
          "name": userModel.displayName,
          "phone": userModel.phoneNumber,
          "photoUrl": userModel.photoURL,
        });
        log('user was added', name: "UserToFireBase");
      }
    } catch (e) {
      log('$e - ', name: 'Error from _addUserToCollection');
    }
  }

  void updateUser(String field, String value, String uid) {
    users.doc(uid).update({field: value});
  }

  Future<UserModel> getUserFromUserCollection(String uid) async {
    final user = await users.doc(uid).get();
    final userModel = UserModel.fromJson(user.data() as Map<String, dynamic>);
    return userModel;
  }

  /// send user message to firebase
  /// initialize chat if isEmpty
  /// chatRoom id(docId) = UserCredentials_uid(UserModel_uid)

  /// change String name to uid!!!!
  void sendMessage(String content, String uid) {
    DateTime dateTime = DateTime.now();

    final message = MessageModel(content: content, sendAt: dateTime, sendBy: uid);
    final json = message.toJson();

    chats.doc(uid).collection(messageCollection).add(json);
    chats.doc(uid).update({'recentMessage': json});
  }

  Future<void> initializeChat(String content, UserModel userModel) async {
    DateTime dateTime = DateTime.now();
    List<String> userIds = [userModel.uid];

    final recentMessage = MessageModel(content: content, sendAt: dateTime, sendBy: userModel.uid);
    final initChat = ChatModel(name: userModel.displayName, createdAt: dateTime, status: 1, uid: userModel.uid, userIds: userIds, recentMessage: recentMessage);

    await chats.doc(userModel.uid).set(initChat.toJson());
    // await chats.doc(userModel.uid).collection(messageCollection).add(initChat.toJson());уйт
  }

  /// request for visits by user from firebase
  Future<dynamic> getVisitsByUser(String uid) async {
    try {
      QuerySnapshot querySnapshot = await users.doc(uid).collection('visits').get();
      return querySnapshot;
    } catch (e) {
      log('$e', name: 'Exception by getVisitsByUser()');
    }
  }

  /// request for all rooms
  Future<List<RoomModel>?> getRooms() async {
    try {
      List<RoomModel> roomsList = [];
      final snapshot = await rooms.get();

      for (var element in snapshot.docs) {
        roomsList.add(RoomModel.fromJson(element.data() as Map<String, dynamic>));
      }

      return roomsList;
    } catch (e) {
      log('$e', name: 'Exception by getRooms()');
      return null;
    }
  }

  void sendBooking(DateTime dateStart, DateTime dateEnd, String roomName, int totalPrice, String uid, String roomType) {
    const String status = 'Забронировано';
    Map<String, dynamic> json = <String, dynamic>{
      'dateEnd': dateEnd,
      'dateStart': dateStart,
      'roomName': roomName,
      'totalPrice': totalPrice,
      'uid': uid,
      'roomType': roomType,
      'status': status,
    };

    bookings.add(json);
  }
// }
}
