import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'default_environment.dart';

@lazySingleton
class FirebaseConfig {
  static late FirebaseApp app;
  static late DocumentReference userDoc;
  static late Reference userStorage;

  static init() async {
    app = await Firebase.initializeApp();
    userDoc = FirebaseFirestore.instance
        .collection(DefaultEnvironment.learningVocabulary)
        .doc(DefaultEnvironment.environment);
    userStorage = FirebaseStorage.instance
        .ref(DefaultEnvironment.learningVocabulary)
        .child(DefaultEnvironment.environment);
  }
}
