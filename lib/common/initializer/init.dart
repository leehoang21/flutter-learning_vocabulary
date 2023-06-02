import 'package:flutter_learning_english/common/configs/firebase_config.dart';

import '../di/di.dart';

class AppInitializer {
  static Future<void> init() async {
    configureDependencies();
    FirebaseConfig.init();
  }
}
