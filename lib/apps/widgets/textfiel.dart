import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFielWidget extends StatelessWidget {
  final String title;
  final bool? noTitle;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLines;
  final TextInputType? type;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  const TextFielWidget({
    super.key,
    required this.title,
    required this.controller,
    this.maxLine,
    this.minLines,
    this.type,
    this.enabled,
    this.inputFormatters,
    this.noTitle,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (noTitle == true)
            ? const Row()
            : Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
        TextField(
          inputFormatters: inputFormatters,
          controller: controller,
          keyboardType: type,
          maxLines: maxLine,
          minLines: minLines,
          enabled: enabled,
          decoration: InputDecoration(
            suffix: suffix,
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value){
            
          },
        ),
      ],
    );
  }
}
