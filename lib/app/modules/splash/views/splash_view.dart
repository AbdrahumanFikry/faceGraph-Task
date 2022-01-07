import 'package:bdaya_custom_splash/bdaya_custom_splash.dart';
import 'package:face_graph_task/app/utilities/path_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BdayaCustomSplash(
      splashDuration: 2,
      backgroundBuilder: (child) {
        return Center(
          child: Image.asset(
            PathUtil.appIcon,
            height: 200.sp,
            // width: 200.sp,
          ),
        );
      },
      initFunction: () async {
        return controller.initFunction(context);
      },
      logoBuilder: () {
        return const SizedBox.shrink();
      },
      onNavigateTo: (Object? result) async {
        if (result.toString().isNotEmpty) Get.offAllNamed(result.toString());
      },
    );
  }
}
