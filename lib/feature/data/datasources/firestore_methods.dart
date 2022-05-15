import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_ma/feature/data/models/booking_model.dart';
import 'package:hotel_ma/feature/data/models/chat_model.dart';
import 'package:hotel_ma/feature/data/models/message_model.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/models/room_type_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';

import '../../../core/locator_service.dart';
import '../models/user_model.dart';
import '../repositories/firestore_repository.dart';
import '../repositories/sql_repository.dart';

class FirestoreMethods {
  final messageCollection = 'messages';
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  CollectionReference roomType = FirebaseFirestore.instance.collection('roomTypes');
  CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  /// adding a first-auth users to firebase
  Future<UserModel?> addUserToCollection(UserModel? userModel) async {
    try {
      final dataExists = await users.doc(userModel!.uid).get();
      log(dataExists.data().toString(), name: "DATAEXISTS");

      if (dataExists.exists) {
        log('user already added', name: "UserToFireBase");
        final userModel = UserModel.fromJson(dataExists.data() as Map<String, dynamic>);
        return userModel;
      } else {
        users.doc(userModel.uid).set({
          "uid": userModel.uid,
          "email": userModel.email,
          "name": userModel.name,
          "phone": userModel.phoneNumber,
          "photoUrl": userModel.photoURL,
          "isNotifications": true,
        });
        log('user was added', name: "UserToFireBase");
        return null;
      }
    } catch (e) {
      log('$e - ', name: 'Error from _addUserToCollection');
      return null;
    }
  }

  void updateUser(dynamic value, String fieldName, String uid) {
    users.doc(uid).update({fieldName: value});
  }

  void updateField(dynamic value, String fieldName, String uid) async {
    try {
      locator.get<FirestoreMethods>().updateUser(value, fieldName, uid);
      final userModel = await locator.get<FirestoreRepository>().getUserFromUserCollection(uid);
      locator.get<SqlRepository>().userToSql(userModel);
      print('EXCEPTION NONE');
    } catch (e) {
      print('EXCEPTION $e');
    }
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
    final initChat = ChatModel(name: userModel.name, createdAt: dateTime, status: 1, uid: userModel.uid, userIds: userIds, recentMessage: recentMessage);

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
      List<RoomTypeModel> roomTypesList = [];
      final snapshot = await rooms.get();
      final roomTypeSnapshot = await roomType.get();

      for (var element in roomTypeSnapshot.docs) {
        roomTypesList.add(RoomTypeModel.fromJson(element.data() as Map<String, dynamic>, element.id));
      }

      for (var element in snapshot.docs) {
        roomsList.add(RoomModel.fromJson(element.data() as Map<String, dynamic>, element.id, roomTypesList));
      }

      return roomsList;
    } catch (e) {
      log('$e', name: 'Exception by getRooms()');
      return null;
    }
  }

  void createBooking(BookingModel bookingModel) {
    bookings.add(bookingModel.toJson());
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
