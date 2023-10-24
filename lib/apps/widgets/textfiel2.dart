import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFiel2Widget extends StatefulWidget {
  final String title;
  final bool? noTitle;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLines;
  final TextInputType? type;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Function onChanged;
  const TextFiel2Widget({
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
    required this.onChanged,
  });

  @override
  State<TextFiel2Widget> createState() => _TextFiel2WidgetState();
}

class _TextFiel2WidgetState extends State<TextFiel2Widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.noTitle == true)
            ? const Row()
            : Text(
                widget.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
        TextField(
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.type,
          maxLines: widget.maxLine,
          minLines: widget.minLines,
          enabled: widget.enabled,
          decoration: InputDecoration(
            suffix: widget.suffix,
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
          onChanged: (value) {
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
