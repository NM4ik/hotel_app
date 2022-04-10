import 'package:firebase_core/firebase_core.dart';

class FireBase {
  static Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp(
      name: "Hotel_MA",
      options: const FirebaseOptions(
          apiKey: "AIzaSyCMFCLLYlwDvBYTRPIsqcyhn2hHnGPdaFA",
          appId: "1:774509000650:android:d04a9b60cade6a4963c133",
          messagingSenderId: "774509000650",
          projectId: "hotelmobileapp-flutter"),
    );
  }
}
