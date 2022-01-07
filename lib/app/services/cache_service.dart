import 'package:bdaya_repository_pattern/bdaya_repository_pattern.dart';
import 'package:face_graph_task/app/data/enums/chair_status.dart';
import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:face_graph_task/app/data/repositories/chairs_repo.dart';
import 'package:get/get.dart';

class CacheService extends CacheServiceInterface with GetxServiceMixin {
  static CacheService get to => Get.find();

  late ChairsRepo _chairsRepo;

  ChairsRepo get chairRepo => _chairsRepo;

  @override
  Future<void> initRepos() async {
    await (_chairsRepo = ChairsRepo()).init();
  }

  @override
  void registerTypeAdapters() {
    Hive.registerAdapter(ChairAdapter());
    Hive.registerAdapter(ChairStatusAdapter());
  }
}
