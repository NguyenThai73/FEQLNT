import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String msg;
  const ToastWidget({Key? key, required this.msg, required this.color, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: const Color.fromRGBO(255, 129, 130, 0.4)),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 12.0,
          ),
          Text(msg),
        ],
      ),
    );
  }
}


void showToast({required BuildContext context, required String msg, required Color color, required Icon icon, int? timeHint}) {
  FToast fToast = FToast();
  fToast.init(context);
  return fToast.showToast(
      //Đang m ắc
      child: ToastWidget(msg: msg, color: color, icon: icon),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: timeHint ?? 4),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: 30.0,
          right: 20.0,
        );
      });
}
