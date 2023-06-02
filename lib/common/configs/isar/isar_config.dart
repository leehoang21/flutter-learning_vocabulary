import 'package:flutter_learning_english/common/configs/isar/isar_box_name.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/user_model.dart';

class IsarConfig {
  late Isar userBox;

  Future<void> init() async {
    await openBox();
  }

  Future openBox() async {
    final dir = await getApplicationDocumentsDirectory();
    userBox = await Isar.open(
      [UserModelSchema],
      directory: dir.path,
      name: IsarBoxName.userBox,
    );
  }
}
