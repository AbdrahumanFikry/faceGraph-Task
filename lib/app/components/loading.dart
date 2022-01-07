import 'dart:io';

import 'package:face_graph_task/app/utilities/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color? color;

  const Loading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Platform.isAndroid
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? ColorUtil.primaryColor,
                ),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
