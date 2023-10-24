// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final Map<int, String> listSelecet;
  final String title;
  final int? selectedIndex;
  final Function onSelect;
  final bool? noTitle;
  final Color? background;

  const DropDownWidget({
    super.key,
    required this.listSelecet,
    required this.title,
    this.selectedIndex,
    required this.onSelect,
    this.noTitle,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (noTitle == true)
            ? Row()
            : Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: background ?? Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Colors.grey),
                ),
                height: 50,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: listSelecet.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                    value: selectedIndex,
                    onChanged: (value) {
                      onSelect(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
