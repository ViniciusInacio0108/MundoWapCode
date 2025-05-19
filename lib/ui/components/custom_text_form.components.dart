import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mundo_wap_teste/utils/regexs.dart';
import 'package:mundo_wap_teste/utils/text_styles.dart';

/// This class is used for the custom text form field with the apps design.
///
/// When [validator] value is null, it will be set to validate: empty, null and with safe input regex.
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormat;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.inputFormat,
    this.textInputType,
    this.validator,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ??
          (value) {
            if (value == null) {
              return 'Não pode ser vazio.';
            } else if (value.isEmpty) {
              return 'Não pode ser vazio.';
            } else if (!MyAppRegex.safeInputRegex.hasMatch(value)) {
              return 'Caracteres inválidos.';
            } else {
              return null;
            }
          },
      textInputAction: textInputAction,
      inputFormatters: inputFormat,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: MyAppTextStyle.labelStyleBold.copyWith(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
