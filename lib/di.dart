import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:todo_one/app/data/hive_service.dart';

import 'app/data/note_model.dart';

class DependencyInjection {
  static Future<void> init() async {

    await Get.putAsync<Box<Note>>(() async {
      var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
      Hive.registerAdapter(NoteAdapter());
      return await Hive.openBox('notes');
    });

    Get.put(HiveService(box: Get.find()), permanent: true);
  }
}