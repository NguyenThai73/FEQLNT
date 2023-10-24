import 'package:fe/apps/widgets/border_textfield.dart';
import 'package:flutter/material.dart';

class ChangePasswordScrren extends StatefulWidget {
  const ChangePasswordScrren({super.key});

  @override
  State<ChangePasswordScrren> createState() => _ChangePasswordScrrenState();
}

class _ChangePasswordScrrenState extends State<ChangePasswordScrren> {
  TextEditingController passwordNewController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Thay đổi mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BorderTextField(
                controller: passwordNewController,
                title: "Mật khẩu mới",
                placeholder: 'Nhật mật khẩu mới',
                isPassword: true,
                onChangeText: (value) {},
              ),
              const SizedBox(height: 30),
              BorderTextField(
                controller: confirmPassController,
                title: "Nhập lại mật khẩu",
                placeholder: 'Nhập lại mật khẩu',
                isPassword: true,
                onChangeText: (value) {},
              ),
              const SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: 170,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () {
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cập nhật",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
