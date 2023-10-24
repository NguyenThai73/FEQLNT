// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPickerWidget extends StatefulWidget {
  final String title;
  final bool? noTitle;
  final String? dateSelected;
  final Function onSelected;

  const MonthPickerWidget({
    super.key,
    required this.title,
    this.noTitle,
    this.dateSelected,
    required this.onSelected,
  });

  @override
  State<MonthPickerWidget> createState() => _MonthPickerWidgetState();
}

class _MonthPickerWidgetState extends State<MonthPickerWidget> {
  DateTime selectedDate = DateTime.now();
  String? dateDisplay;

  @override
  void initState() {
    super.initState();
    if (widget.dateSelected != null) {
      dateDisplay = DateFormat('MM-yyyy').format(DateTime.parse((widget.dateSelected!)).toLocal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.noTitle == true)
            ? const Row()
            : Text(
                widget.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.grey),
          ),
          height: 50,
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateDisplay ?? 'Chọn tháng', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20.0),
              dateDisplay == null
                  ? IconButton(
                      onPressed: () async {
                        showMonthPicker(
                          context: context,
                          initialDate: DateTime.now(),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                              dateDisplay = DateFormat('MM-yyyy').format(selectedDate);
                              widget.onSelected( DateFormat('yyyy-MM-dd').format(selectedDate));
                            });
                          }
                        });
                      },
                      icon: Icon(Icons.date_range),
                      color: Colors.blue[400])
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          dateDisplay = null;
                          widget.onSelected(null);
                        });
                      },
                      icon: Icon(Icons.close)),
            ],
          ),
        )
      ],
    );
  }
}
