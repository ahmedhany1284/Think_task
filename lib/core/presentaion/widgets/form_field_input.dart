import 'package:flutter/material.dart';
import 'package:think_task/core/colors/app_colors.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.type,
    this.onChange,
    this.onSubmit,
    this.onTap,
    required this.label,

    this.suffixPressed, this.onSaved, this.onEditingComplete,
  });

  final TextEditingController controller;
  final TextInputType type;
  final Function? onChange;
  final Function? onSubmit;
  final Function? onTap;
  final Function? onSaved;
  final Function? onEditingComplete;
  final String label;

  final VoidCallback? suffixPressed;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final bool isPassword = false;

  final bool clickable = true;

  final double borderRadius = 20;
  bool isFocus = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocus = focus;
        });
      },
      child: SizedBox(
        height: isError ? 90 : 60,
        child: TextFormField(
          onEditingComplete: widget.onEditingComplete as void Function()?,
          onSaved: widget.onSaved as void Function(String?)?,
          controller: widget.controller,
          keyboardType: widget.type,
          obscureText: isPassword,

          onFieldSubmitted: widget.onSubmit as void Function(String)?,
          onChanged: widget.onChange as void Function(String)?,
          onTap: widget.onTap as void Function()?,

          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          cursorHeight: 25,
          decoration: InputDecoration(
            labelText: widget.label,
            contentPadding: const EdgeInsets.only(top: 35, left: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 5.0,
                color: AppColors.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 5.0,
                color: AppColors.secondary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1.0,
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                width: 1.0,
                color: AppColors.error,
              ),
            ),
            filled: true,
            fillColor: (isFocus || widget.controller.text.isNotEmpty)
                ? AppColors.background
                : AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
