import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';

class FirestoreRepository {
  final FirestoreData firestoreData;

  FirestoreRepository({required this.firestoreData});

  personToUserCollection(userModel) {
    firestoreData.addUserToCollection(userModel);
  }

  getUserFromUserCollection(String uid) {
    firestoreData.getUserFromUserCollection(uid);
  }

  updateUser(String field, String value, String uid) {
    firestoreData.updateUser(field, value, uid);
  }

  Future<List<RoomModel>?> getRooms() async => await firestoreData.getRooms();
}
