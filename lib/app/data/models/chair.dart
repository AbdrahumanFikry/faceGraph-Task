import 'dart:io';

import 'package:face_graph_task/app/data/enums/chair_status.dart';
import 'package:hive_flutter/adapters.dart';
import '_hive_type_ids.dart';

part 'chair.g.dart';

@HiveType(typeId: chairTypeId)
class Chair extends HiveObject {
  @HiveField(1)
  late final String iD;

  @HiveField(2)
  late String title;

  @HiveField(4)
  late String? description;

  @HiveField(5)
  late DateTime dateTime;

  @HiveField(7)
  late ChairStatus status;

  @HiveField(9)
  late String picturePath;

  Chair(
    this.iD, {
    required this.title,
    this.description,
    required this.picturePath,
    required this.dateTime,
    required this.status,
  });
}
