import 'dart:io';

import 'package:face_graph_task/app/components/app_button.dart';
import 'package:face_graph_task/app/components/app_text_field.dart';
import 'package:face_graph_task/app/components/extensions.dart';
import 'package:face_graph_task/app/data/enums/chair_status.dart';
import 'package:face_graph_task/app/modules/add_edit_chair/components/image_handler.dart';
import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:face_graph_task/app/utilities/color_util.dart';
import 'package:face_graph_task/app/utilities/validators.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_edit_chair_controller.dart';

class AddEditChairView extends GetView<AddEditChairController> {
  const AddEditChairView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.chair != null ? 'Edit Chair' : 'Add new chair'),
        centerTitle: false,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: [
            AppTextField(
              controller.title,
              labelText: 'Title',
              underLine: false,
              borderColor: ColorUtil.darkBlue,
              hintText: 'Please enter chair title here',
              validator: const QuickTextValidator(),
            ),
            AppTextField(
              controller.desc,
              labelText: 'Description',
              underLine: false,
              borderColor: ColorUtil.darkBlue,
              hintText: 'Please enter chair description here',
              maxLines: 5,
            ),
            AppTextField(
              controller.dateTime,
              labelText: 'Date',
              underLine: false,
              borderColor: ColorUtil.darkBlue,
              hintText:
                  'Please enter date and time when the visual note is taken here',
              validator: const QuickTextValidator(),
              onTap: () async {
                final result = await AppUtil.chooseDateTime(
                  entryMode: DatePickerEntryMode.calendar,
                  pickTimeToo: true,
                );
                if (result != null) {
                  controller.chairDateTime(result);
                  controller.dateTime.text = result.toLongUserString();
                }
              },
            ),
            AppTextField(
              controller.status,
              labelText: 'Status',
              underLine: false,
              borderColor: ColorUtil.darkBlue,
              hintText: 'Please enter chair status here',
              validator: const QuickTextValidator(),
              onTap: () async {
                final result = await AppUtil.openBottomSheetList<ChairStatus>(
                  ChairStatus.values,
                  (status) => status.name,
                );
                if (result != null) {
                  controller.chairStatus(result);
                  controller.status.text = result.name;
                }
              },
            ),
            UnconstrainedBox(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: Get.width * 0.5,
                width: Get.width * 0.5,
                child: Obx(
                  () => ImageHandler(
                    title: 'Picture',
                    image: controller.chairImg.value != null
                        ? File(controller.chairImg.value!)
                        : null,
                    addFunction: () async {
                      final result =
                          await AppUtil.pickFiles(allowMultiple: false);
                      if (result.isNotEmpty) {
                        controller.chairImg(result.first.path);
                      }
                    },
                    removeFunction: () => controller.chairImg.value = null,
                  ),
                ),
              ),
            ),
            AppButton(
              title: controller.chair != null ? 'Add' : 'Save',
              onTap: () => controller.save(),
            ),
          ],
        ),
      ),
    );
  }
}
