// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:flutter/material.dart';

class EditProfileScrren extends StatefulWidget {
  final NguoiDungModel nguoiDungModel;
  final Function callBack;
  const EditProfileScrren({super.key, required this.nguoiDungModel, required this.callBack});

  @override
  State<EditProfileScrren> createState() => _EditProfileScrrenState();
}

class _EditProfileScrrenState extends State<EditProfileScrren> {
  NguoiDungModel nguoiDungModel = NguoiDungModel();

  TextEditingController username = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController namSinh = TextEditingController();
  TextEditingController sdt = TextEditingController();
  int countFile = 0;
  String? birth;

  int selectedGender = 0;

  Map<int, String> listGender = {
    0: 'Male',
    1: 'Female',
  };

  @override
  void initState() {
    super.initState();
    nguoiDungModel = widget.nguoiDungModel;
    username.text = nguoiDungModel.username ?? "";
    fullName.text = nguoiDungModel.fullName ?? "";
    namSinh.text = nguoiDungModel.namSinh ?? "";
    sdt.text = nguoiDungModel.sdt ?? "";
    if (nguoiDungModel.fileCccd != null) {
      List<String> listFile = nguoiDungModel.fileCccd!.split(",");
      countFile = listFile.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            widget.callBack(widget.nguoiDungModel);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Chỉnh sửa Thông tin",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFielWidget(
                title: 'Họ và tên',
                controller: fullName,
              ),
              SizedBox(height: 25),
              TextFielWidget(
                type: TextInputType.number,
                title: 'Năm sinh',
                controller: namSinh,
              ),
              SizedBox(height: 25),
              TextFielWidget(
                type: TextInputType.phone,
                title: 'Số điện thoại',
                controller: sdt,
              ),
              SizedBox(height: 25),
              Text(
                "CCCD",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Colors.grey),
                ),
                height: 50,
                child: InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    onLoading(context);
                    var filename = await handleUploadFile();
                    setState(() {
                      if (filename != null) {
                        nguoiDungModel.fileCccd = filename;
                        List<String> listFile = nguoiDungModel.fileCccd!.split(",");
                        countFile = listFile.length;
                      }
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đã tải lên : $countFile file",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: 170,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                    child: Row(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
