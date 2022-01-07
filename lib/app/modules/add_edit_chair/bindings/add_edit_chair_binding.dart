import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:get/get.dart';

import '../controllers/add_edit_chair_controller.dart';

class AddEditChairBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    Get.lazyPut<AddEditChairController>(
      () => AddEditChairController(args is Chair ? args : null),
    );
  }
}
