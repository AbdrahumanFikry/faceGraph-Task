import 'dart:io';

import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:face_graph_task/app/utilities/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageHandler extends StatelessWidget {
  final File? image;
  final String title;
  final Function() addFunction;
  final Function() removeFunction;
  final Color borderColor;

  const ImageHandler({
    Key? key,
    required this.title,
    required this.image,
    required this.addFunction,
    required this.removeFunction,
    this.borderColor = ColorUtil.darkBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              title,
              style: AppUtil.textStyle(
                color: borderColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (image == null) addFunction();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppUtil.borderRadius10,
                  color: ColorUtil.lightGrey.withOpacity(0.75),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: AppUtil.borderRadius10,
                            child: Image.file(
                              image!,
                              height: Get.height,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 7.0,
                            left: 7.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: GestureDetector(
                                onTap: removeFunction,
                                child: const Icon(
                                  CupertinoIcons.multiply,
                                  color: ColorUtil.whiteColor,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.add,
                              color: borderColor,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
