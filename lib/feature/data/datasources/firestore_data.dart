import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../models/user_model.dart';

class FirestoreData {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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

  Future<dynamic> getVisitsByUser(String uid) async {
    try {
      List<Visit> visits = [];
      QuerySnapshot querySnapshot = await users.doc(uid).collection('visits').get();
      querySnapshot.docs.map((e) => visits.add(Visit.fromJson(e.data() as Map<String, dynamic>))).toList();
      return visits;
    } catch (e) {
      print('Exception by getVisitsByUser $e');
    }
  }
}

class Visit extends Equatable {
  final String dateEnd;
  final String dateStart;
  final String price;
  final String roomName;

  const Visit({required this.dateEnd, required this.dateStart, required this.price, required this.roomName});

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(dateEnd: json['dateEnd'], dateStart: json['dateStart'], price: json['price'], roomName: json['roomName']);

  @override
  List<Object> get props => [dateEnd, dateStart, price, roomName];
}