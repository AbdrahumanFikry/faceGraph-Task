import 'dart:io';
import 'package:face_graph_task/app/components/app_button.dart';
import 'package:face_graph_task/app/components/loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'color_util.dart';

class AppUtil {
  static BorderRadius borderRadius0 = BorderRadius.circular(0);
  static BorderRadius borderRadius7 = BorderRadius.circular(7.5);
  static BorderRadius borderRadius10 = BorderRadius.circular(10.0);
  static BorderRadius borderRadius25 = BorderRadius.circular(25.0);

  static OutlineInputBorder outLineInputBorder({
    Color? color,
    BorderRadius? borderRadius,
  }) =>
      OutlineInputBorder(
        borderRadius: borderRadius ?? borderRadius10,
        borderSide: BorderSide(
          color: color ?? Colors.transparent,
          width: 0.5,
        ),
      );

  static OutlineInputBorder errorOutLineInputBorder({
    BorderRadius? borderRadius,
  }) =>
      OutlineInputBorder(
        borderRadius: borderRadius ?? borderRadius10,
        borderSide: BorderSide(
          color: Theme.of(Get.context!).errorColor,
          width: 0.5,
        ),
      );

  static UnderlineInputBorder underLineInputBorder({
    Color? color,
    BorderRadius? borderRadius,
  }) =>
      UnderlineInputBorder(
        borderRadius: borderRadius ?? borderRadius10,
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ),
      );

  static UnderlineInputBorder errorUnderLineInputBorder({
    BorderRadius? borderRadius,
  }) =>
      UnderlineInputBorder(
        borderRadius: borderRadius ?? borderRadius10,
        borderSide: BorderSide(
          color: Theme.of(Get.context!).errorColor,
        ),
      );

  static ThemeData appLightTheme = ThemeData(
    primaryColor: ColorUtil.primaryColor,
    scaffoldBackgroundColor: ColorUtil.whiteScaffold,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static TextStyle textStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextDecoration? decoration,
    String? fontFamily,
    double? height,
  }) {
    return TextStyle(
      color: color ?? ColorUtil.blackColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      locale: locale,
      decoration: decoration,
      shadows: shadows,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static void showAlertSnack({
    String? contentText,
    Duration? duration,
    bool pin = false,
    SnackPosition? snackPosition,
    Icon? icon,
  }) {
    Get.closeCurrentSnackbar();
    Get.showSnackbar(
      GetSnackBar(
        titleText: const SizedBox.shrink(),
        mainButton: const SizedBox.shrink(),
        padding: const EdgeInsets.only(
          bottom: 20.0,
          left: 10.0,
          right: 10.0,
          top: 10.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        snackPosition: snackPosition ?? SnackPosition.BOTTOM,
        backgroundColor: ColorUtil.darkBlue,
        messageText: SizedBox(
          width: Get.width,
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (icon != null) icon,
              const SizedBox(
                width: 10.0,
              ),
              Text(
                contentText ?? 'Alert',
                style: TextStyle(
                  color: ColorUtil.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
        ),
        borderRadius: 5.0,
        duration: pin ? null : duration ?? const Duration(seconds: 3),
        isDismissible: !pin,
      ),
    );
  }

  static Future<bool?> showAlertDialog({
    String? title,
    String? contentText,
    Function? onConfirm,
    String? confirmText,
    bool enableCancel = false,
    bool noMargin = false,
    String? cancelText,
    RxBool? loading,
    Widget? child,
  }) async {
    return Get.dialog<bool>(
      AlertDialog(
        insetPadding: noMargin
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 24.0,
              ),
        titlePadding: const EdgeInsets.symmetric(vertical: 5.0),
        contentPadding: EdgeInsets.zero,
        backgroundColor: ColorUtil.whiteScaffold,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius10,
        ),
        content: SingleChildScrollView(
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (enableCancel)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    splashRadius: 100.sp,
                    onPressed: () => Get.back(result: false),
                    icon: Icon(
                      CupertinoIcons.clear,
                      color: Theme.of(Get.context!).errorColor,
                      size: 90.sp,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Text(
                  title ?? 'Alert',
                  textAlign: TextAlign.center,
                  style: textStyle(
                    color: ColorUtil.orangeColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
              ),
              if (loading?.value != null && loading?.value == true)
                const Loading()
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: child ??
                      Text(
                        contentText ?? '-',
                        style: const TextStyle(
                          color: ColorUtil.blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          height: 1.5,
                        ),
                        maxLines: 10,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              AppButton(
                elevation: 0.0,
                backgroundColor: ColorUtil.primaryColor,
                borderRadius: borderRadius10,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 30.0,
                ),
                title: confirmText ?? 'Confirm',
                onTap: () {
                  if (onConfirm != null) {
                    onConfirm.call();
                  } else {
                    Get.back(result: true);
                  }
                },
              ),
            ],
          ),
        ),
        buttonPadding: EdgeInsets.zero,
      ),
    );
  }

  static Future<List<File>> pickFiles({
    bool allowMultiple = false,
    FileType fileType = FileType.image,
    bool allowCompression = true,
  }) async {
    final List<File> files = <File>[];
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: fileType,
        allowCompression: allowCompression,
      );
      if (result != null) {
        for (final file in result.files) {
          debugPrint(file.name);
          debugPrint(file.path);

          files.add(File(file.path!));
        }
      }
    } catch (e) {
      debugPrint('FilePicker error : ${e.toString()}');
    }
    return files;
  }

  static Future<DateTime?> chooseDateTime({
    bool pickTimeToo = false,
    DatePickerMode mode = DatePickerMode.day,
    DatePickerEntryMode entryMode = DatePickerEntryMode.calendarOnly,
    DateTime? initialDateTime,
  }) async {
    final date = await Get.dialog<DateTime>(
      Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: ColorUtil.primaryColor,
          ),
        ),
        child: DatePickerDialog(
          initialDate: initialDateTime ??
              DateTime.now().subtract(
                const Duration(days: 7670),
              ),
          firstDate: DateTime.now().subtract(
            const Duration(days: 7670),
          ),
          lastDate: DateTime.now(),
          initialCalendarMode: mode,
          initialEntryMode: entryMode,
        ),
      ),
    );
    if (date != null && pickTimeToo) {
      final time = await Get.dialog<TimeOfDay>(
        Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: ColorUtil.primaryColor,
            ),
          ),
          child: TimePickerDialog(
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          ),
        ),
      );
      if (time != null) {
        return DateTime(
            date.year, date.month, date.day, time.hour, time.minute);
      } else {
        return date;
      }
    } else {
      return date;
    }
  }

  static Future<T?> openBottomSheetList<T>(
    List<T> items,
    String Function(T item)? listDisplayFunc, {
    String? title,
  }) async {
    if (listDisplayFunc != null && items.isNotEmpty) {
      T? result = items[0];
      return Get.bottomSheet<T>(
        Container(
          height: Get.height * 0.35,
          decoration: const BoxDecoration(
            color: ColorUtil.whiteScaffold,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 10.0,
          ),
          child: Column(
            children: <Widget>[
              if (title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: ColorUtil.blackColor,
                      fontSize: 70.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: ColorUtil.whiteScaffold,
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(),
                  onSelectedItemChanged: (int index) => result = items[index],
                  children: items
                      .map<Widget>(
                        (T value) => Text(
                          listDisplayFunc(value),
                          style: const TextStyle(
                            color: ColorUtil.darkBlue,
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      )
                      .toList(),
                ),
              ),
              AppButton(
                height: 45.0,
                title: 'Confirm',
                margin: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                onTap: () => Get.back(
                  result: result,
                  closeOverlays: false,
                ),
              ),
            ],
          ),
        ),
        isDismissible: false,
      );
    }
  }
}
