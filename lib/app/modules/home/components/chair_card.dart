import 'dart:io';

import 'package:face_graph_task/app/components/extensions.dart';
import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:face_graph_task/app/routes/app_pages.dart';
import 'package:face_graph_task/app/services/cache_service.dart';
import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:face_graph_task/app/utilities/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChairCard extends StatelessWidget {
  final Chair chair;

  const ChairCard({required this.chair, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ADD_EDIT_CHAIR, arguments: chair),
      child: Dismissible(
        key: ValueKey<String>(chair.key),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Theme.of(context).errorColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.delete,
                  color: ColorUtil.whiteColor,
                  size: 100.sp,
                ),
              ),
            ],
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          final result = await AppUtil.showAlertDialog(
            title: 'Are you sure',
            contentText: 'Deleting ${chair.title} from list and cache?',
            enableCancel: true,
          );
          if (result == true) {
            await CacheService.to.chairRepo.removeChairFromCache(chair.iD);
            return true;
          } else {
            return false;
          }
        },
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(
                    File(chair.picturePath),
                    fit: BoxFit.cover,
                    height: 200.sp,
                    width: 200.sp,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          chair.title,
                          style: AppUtil.textStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorUtil.blackColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: SizedBox(
                            height: 90.sp,
                            child: Text(
                              chair.description ?? '',
                              style: AppUtil.textStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorUtil.mediumGrey,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: ColorUtil.blackColor,
                              size: 50.sp,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                chair.dateTime.toLongUserString(),
                                style: AppUtil.textStyle(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtil.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    chair.status.name,
                    style: AppUtil.textStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorUtil.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1.0, thickness: 1.0),
          ],
        ),
      ),
    );
  }
}
