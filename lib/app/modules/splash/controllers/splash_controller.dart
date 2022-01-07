import 'package:face_graph_task/app/routes/app_pages.dart';
import 'package:face_graph_task/app/services/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashController extends GetxController {
  Future<void> _initAppCache() async {
    try {
      await Hive.initFlutter('v1');
      await (Get.put(CacheService())).init();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> initFunction(BuildContext context) async {
    try {
      await _initAppCache();
    } catch (e) {}
    return Routes.HOME;
  }
}
