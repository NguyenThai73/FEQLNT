// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/nguoi.thue/bloc/quan_ly_nguoi_dung_bloc.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image.hop.dong.dart';

class ThongTinNguoiDung extends StatefulWidget {
  final NguoiDungModel nguoiDungModel;
  final Function callBack;
  const ThongTinNguoiDung({super.key, required this.nguoiDungModel, required this.callBack});

  @override
  State<ThongTinNguoiDung> createState() => _ThongTinNguoiDungState();
}

class _ThongTinNguoiDungState extends State<ThongTinNguoiDung> {
  final _bloc = QuanLyNguoiDungBloc();
  NguoiDungModel nguoiDungModel = NguoiDungModel();
  TextEditingController username = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController namSinh = TextEditingController();
  TextEditingController sdt = TextEditingController();
  int countFile = 0;
  bool edit = false;
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
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              widget.callBack(nguoiDungModel);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Center(
            child: Text(
          "Thông tin người thuê",
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  edit = !edit;
                });
              },
              icon: Icon(
                edit ? Icons.done : Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocConsumer<QuanLyNguoiDungBloc, QuanLyNguoiDungState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyNguoiDungLoading) {
              onLoading(context);
              return;
            } else if (state is SuaSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Cập nhật thành công",
                color: const Color.fromARGB(255, 120, 255, 125),
                icon: const Icon(Icons.done),
              );
              widget.callBack(state.nguoiDungModel);
            } else if (state is QuanLyNguoiDungError) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: state.error,
                color: Colors.orange,
                icon: const Icon(Icons.warning),
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    !edit
                        ? TextFielWidget(
                            enabled: edit,
                            type: TextInputType.number,
                            title: 'Hợp đồng',
                            controller: TextEditingController(text: nguoiDungModel.hopDong?.phong?.name ?? ""),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hợp đồng",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SropSearchWidget<HopDongModel>(
                                getList: HopDongProvider.getListForNguoiDung(),
                                title: (HopDongModel u) => u.phong!.name!,
                                selected: nguoiDungModel.hopDong,
                                onChange: (value) {
                                  setState(() {
                                    nguoiDungModel.hopDong = value;
                                    nguoiDungModel.idHopDong = value?.id;
                                  });
                                },
                              ),
                            ],
                          ),
                    SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      title: 'Tên đăng nhập',
                      controller: username,
                    ),
                    SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      title: 'Họ và tên',
                      controller: fullName,
                    ),
                    SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      type: TextInputType.number,
                      title: 'Năm sinh',
                      controller: namSinh,
                    ),
                    SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      type: TextInputType.phone,
                      title: 'Số điện thoại',
                      controller: sdt,
                    ),
                    SizedBox(height: 25),
                    !edit
                        ? Row(
                            children: [
                              Expanded(
                                child: TextFielWidget(
                                  enabled: edit,
                                  type: TextInputType.number,
                                  title: "File hợp đồng",
                                  controller: TextEditingController(text: "Đã tải lên : $countFile file"),
                                ),
                              ),
                              (countFile > 0)
                                  ? SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              List<String> listFile = nguoiDungModel.fileCccd!.split(",");
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext context) => ViewCCCDScreen(
                                                    images: listFile,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.visibility,
                                              size: 25,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Row(),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "File hợp đồng",
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
                            ],
                          ),
                    const SizedBox(height: 25),
                    edit
                        ? DropDownWidget(
                            listSelecet: listStatusNguoiDung,
                            title: 'Trạng thái',
                            selectedIndex: nguoiDungModel.status,
                            onSelect: (value) {
                              setState(() {
                                nguoiDungModel.status = value as int;
                              });
                            },
                          )
                        : TextFielWidget(
                            enabled: edit,
                            title: 'Trạng thái',
                            controller: TextEditingController(text: valueStatusNguoiDung(nguoiDungModel.status ?? -1)),
                          ),
                    const SizedBox(height: 30),
                    (edit)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    setState(() {
                                      edit = false;
                                    });
                                    nguoiDungModel.username = username.text;
                                    nguoiDungModel.fullName = fullName.text;
                                    nguoiDungModel.namSinh = namSinh.text;
                                    nguoiDungModel.sdt = sdt.text;
                                    _bloc.add(SuaNguoiDungEvent(nguoiDungModel: nguoiDungModel));
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
                        : Row()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
