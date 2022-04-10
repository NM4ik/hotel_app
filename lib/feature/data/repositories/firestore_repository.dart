import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';

class FirestoreRepository{
  final FirestoreData firestoreData;

  FirestoreRepository({required this.firestoreData});

  personToUserCollection(userModel){
    firestoreData.addUserToCollection(userModel);
  }

}