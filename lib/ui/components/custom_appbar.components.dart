import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';

/// Class for the custom app bar.
///
/// It can be more customized if needed.
class CustomAppBar {
  static AppBar build(String title) {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      toolbarHeight: 80,
      centerTitle: false,
      title: Text(
        title,
        style: MyAppTextStyle.headerStyleBold.copyWith(
          color: Colors.white,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      elevation: 0,
    );
  }
}
