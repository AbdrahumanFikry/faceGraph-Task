import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: () => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GetMaterialApp(
          title: "FaceGraph task",
          theme: AppUtil.appLightTheme,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.native,
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL,
        ),
      ),
    );
  }
}
