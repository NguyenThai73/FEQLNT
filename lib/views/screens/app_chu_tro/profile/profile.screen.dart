// ignore_for_file: use_build_context_synchronously

import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:flutter/material.dart';

class ProFileScreen extends StatefulWidget {
  const ProFileScreen({super.key});

  @override
  State<ProFileScreen> createState() => _ProFileScreenState();
}

class _ProFileScreenState extends State<ProFileScreen> {
  TextEditingController sdt = TextEditingController();
  NguoiDungModel admin = NguoiDungModel();
  void getData() async {
    admin = await NguoiDungProvider.getAdmin();
    sdt.text = admin.sdt ?? "";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Row(),
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          "Cá nhân",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFielWidget(
              title: 'Số điện thoại',
              controller: sdt,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () async {
                       FocusScope.of(context).requestFocus(FocusNode());
                      admin.sdt = sdt.text;
                      await NguoiDungProvider.sua(admin);
                      showToast(
                        context: context,
                        msg: "Cập nhật thành công",
                        color: const Color.fromARGB(255, 120, 255, 125),
                        icon: const Icon(Icons.done),
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Cập nhật",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
