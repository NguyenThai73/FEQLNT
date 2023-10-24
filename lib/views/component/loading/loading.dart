
import 'package:fe/app_theme.dart';
import 'package:fe/views/component/wilps/will.pop.scope.dart';
import 'package:flutter/material.dart';

void onLoading(context) {
  showDialog(
    barrierColor: const Color.fromARGB(34, 158, 158, 158),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const WillPS(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator(color: AppTheme.lightText,)),
          ],
        ),
      );
    },
  );
}