import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';

/// This class is for the custom button with the elevated style
///
/// It already has the loading and desabling while await/async.
class CustomElevatedTextButton extends StatefulWidget {
  final FutureOr<void> Function() onPressed;
  final String title;

  const CustomElevatedTextButton({super.key, required this.onPressed, required this.title});

  @override
  State<CustomElevatedTextButton> createState() => _CustomElevatedTextButtonState();
}

class _CustomElevatedTextButtonState extends State<CustomElevatedTextButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (_loading)
          ? () {}
          : () async {
              try {
                if (mounted) {
                  setState(() {
                    _loading = true;
                  });
                }

                await widget.onPressed();
              } finally {
                if (mounted) {
                  setState(() {
                    _loading = false;
                  });
                }
              }
            },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 45),
        maximumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: (_loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Text(
              widget.title,
              style: MyAppTextStyle.titleStyleNormal.copyWith(
                color: Colors.white,
              ),
            ),
    );
  }
}
