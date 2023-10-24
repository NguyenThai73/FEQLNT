import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ProFileScreen extends StatefulWidget {
  const ProFileScreen({super.key});

  @override
  State<ProFileScreen> createState() => _ProFileScreenState();
}

class _ProFileScreenState extends State<ProFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () async{

        }, child: Text("Call")),
      ),
    );
  }
}
