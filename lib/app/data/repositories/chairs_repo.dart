import 'package:bdaya_repository_pattern/bdaya_repository_pattern.dart';
import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:flutter/cupertino.dart';

class ChairsRepo extends ActiveRepo<String, Chair> {
  @override
  String get boxName => 'chairs';

  Future<void> addChairToCache(Chair chair) async {
    try {
      await put(chair.iD, chair);
    } catch (e) {
      debugPrint('Failed adding chair to cache : ${e.toString()}');
    }
  }

  Future<void> updateChairInCache(Chair chair) async {
    try {
      final cachedChair = getValueById(chair.iD);
      if (cachedChair != null) {
        await deleteKeys([cachedChair.iD]);
        await put(chair.iD, chair);
      }
    } catch (e) {
      debugPrint('Failed update chair in cache : ${e.toString()}');
    }
  }

  Future<void> removeChairFromCache(String chairID) async {
    try {
      await deleteKeys([chairID]);
    } catch (e) {
      debugPrint('Failed deleting chair from cache : ${e.toString()}');
    }
  }
}
