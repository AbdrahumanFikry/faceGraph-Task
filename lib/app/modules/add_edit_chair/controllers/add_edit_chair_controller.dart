import 'package:face_graph_task/app/components/extensions.dart';
import 'package:face_graph_task/app/data/enums/chair_status.dart';
import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:face_graph_task/app/services/cache_service.dart';
import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEditChairController extends GetxController {
  final Chair? chair;

  AddEditChairController(this.chair);

  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController dateTime = TextEditingController();
  final TextEditingController status = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final chairDateTime = Rxn<DateTime>();
  final chairImg = Rxn<String>();
  final chairStatus = Rxn<ChairStatus>();

  Future<void> _addChair(Chair chair) async {
    try {
      await CacheService.to.chairRepo.addChairToCache(chair);
    } catch (e) {
      throw 'Error While Adding chair!';
    }
  }

  Future<void> _updateChair(Chair chair) async {
    try {
      await CacheService.to.chairRepo.updateChairInCache(chair);
    } catch (e) {
      throw 'Error While updating chair!';
    }
  }

  Future<void> save() async {
    final formData = formKey.currentState;
    if (formData!.validate() &&
        chairImg.value != null &&
        chairDateTime.value != null) {
      try {
        if (chair != null) {
          await _updateChair(
            Chair(
              chair!.iD,
              title: title.text,
              description: desc.text,
              picturePath: chairImg.value!,
              dateTime: chairDateTime.value!,
              status: chairStatus.value!,
            ),
          );
        } else {
          await _addChair(
            Chair(
              const Uuid().v1(),
              title: title.text,
              description: desc.text,
              picturePath: chairImg.value!,
              dateTime: chairDateTime.value!,
              status: chairStatus.value!,
            ),
          );
        }
        Get.back();
      } catch (e) {
        await AppUtil.showAlertDialog(
          contentText: e.toString(),
          confirmText: 'Back',
        );
      }
    } else if (chairDateTime.value == null) {
      await AppUtil.showAlertDialog(
        contentText: 'Please select date and time',
        confirmText: 'Back',
      );
    } else if (chairImg.value == null) {
      await AppUtil.showAlertDialog(
        contentText: 'Please attach picture',
        confirmText: 'Back',
      );
    }
  }

  @override
  void onReady() {
    if (chair != null) {
      title.text = chair!.title;
      desc.text = chair!.description ?? '';
      status.text = chair!.status.name;
      dateTime.text = chair!.dateTime.toLongUserString();
      chairDateTime(chair!.dateTime);
      chairImg(chair!.picturePath);
      chairStatus(chair!.status);
    }
    super.onReady();
  }
}
