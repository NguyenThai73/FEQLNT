// ignore_for_file: use_build_context_synchronously

import 'package:fe/apps/widgets/border_textfield.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:flutter/material.dart';

class ChangePasswordScrren extends StatefulWidget {
  final NguoiDungModel nguoiDungModel;
  const ChangePasswordScrren({super.key, required this.nguoiDungModel});

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
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (passwordNewController.text.isEmpty || confirmPassController.text.isEmpty) {
                          showToast(
                            context: context,
                            msg: "Không được để trống",
                            color: Colors.orange,
                            icon: const Icon(Icons.warning),
                          );
                        } else if (passwordNewController.text != confirmPassController.text) {
                          showToast(
                            context: context,
                            msg: "Xác nhận mật khẩu không khớp",
                            color: Colors.orange,
                            icon: const Icon(Icons.warning),
                          );
                        } else {
                          var response = await NguoiDungProvider.changePassword(idUSer: widget.nguoiDungModel.id ?? 0, newpass: passwordNewController.text);
                          if (response) {
                            showToast(
                              context: context,
                              msg: "Thay đổi mật khẩu thành công",
                              color: const Color.fromARGB(255, 212, 255, 214),
                              icon: const Icon(Icons.done),
                            );
                            setState(() {
                              passwordNewController.text = "";
                              confirmPassController.text = "";
                            });
                          } else {
                            showToast(
                              context: context,
                              msg: "Có lỗi xảy ra",
                              color: Colors.orange,
                              icon: const Icon(Icons.warning),
                            );
                          }
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cập nhật",
                            style: TextStyle(
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
