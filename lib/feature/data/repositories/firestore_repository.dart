import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/models/booking_model.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';

import '../models/user_model.dart';

class FirestoreRepository {
  final FirestoreMethods firestoreMethods;

  FirestoreRepository({required this.firestoreMethods});

  Future<UserModel?> addUserToUserCollection(userModel) async {
    return await firestoreMethods.addUserToCollection(userModel);
  }

  Future<UserModel> getUserFromUserCollection(String uid) async {
    return firestoreMethods.getUserFromUserCollection(uid);
  }

  Future<List<RoomModel>?> getRooms() async => await firestoreMethods.getRooms();
  Future<RoomModel?> getRoom(String roomId) async => await firestoreMethods.getRoom(roomId);

  updateUser(String field, String value, String uid) {
    firestoreMethods.updateUser(field, value, uid);
  }

  updateField(dynamic value, String fieldName, String uid) {
    firestoreMethods.updateField(value, fieldName, uid);
  }

  createBooking(BookingModel bookingModel) {
    firestoreMethods.createBooking(bookingModel);
  }
}
