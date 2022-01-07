import 'package:hive_flutter/adapters.dart';

import '../models/_hive_type_ids.dart';

part 'chair_status.g.dart';

@HiveType(typeId: chairStatusTypeId)
enum ChairStatus {
  @HiveField(1)
  open,
  @HiveField(2)
  closed
}
