// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/bloc/quan_ly_hop_dong_bloc.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/ui/image.hop.dong.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ThongTinHopDong extends StatefulWidget {
  final HopDongModel hopDongModel;
  final Function callBack;
  const ThongTinHopDong({super.key, required this.hopDongModel, required this.callBack});

  @override
  State<ThongTinHopDong> createState() => _ThongTinHopDongState();
}

class _ThongTinHopDongState extends State<ThongTinHopDong> {
  final _bloc = QuanLyHopDongBloc();
  TextEditingController numberPeople = TextEditingController(text: "0");
  HopDongModel hopDongModel = HopDongModel();
  int countFile = 0;
  bool edit = false;
  String? dateStart;
  String? dateEnd;
  PhongModel phongOld = PhongModel();
  @override
  void initState() {
    super.initState();
    hopDongModel = widget.hopDongModel;
    phongOld = widget.hopDongModel.phong ?? PhongModel();
    numberPeople.text = "${hopDongModel.numberPeople ?? 0}";
    dateStart = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.hopDongModel.dateStart!).toLocal());
    dateEnd = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.hopDongModel.dateEnd!).toLocal());
    List<String> listFile = hopDongModel.file!.split(",");
    countFile = listFile.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              widget.callBack(hopDongModel);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Center(
            child: Text(
          "Thông tin hợp đồng",
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
      body: BlocConsumer<QuanLyHopDongBloc, QuanLyHopDongState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyHopDongLoading) {
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
              hopDongModel = state.hopDongModel;
              phongOld = hopDongModel.phong??PhongModel();
            } else if (state is QuanLyHopDongError) {
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
                            title: 'Phòng',
                            controller: TextEditingController(text: hopDongModel.phong?.name ?? ""),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phòng",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SropSearchWidget<PhongModel>(
                                getList: PhongProvider.getListChuaThue(),
                                title: (PhongModel u) => u.name!,
                                selected: hopDongModel.phong,
                                onChange: (value) {
                                  setState(() {
                                    hopDongModel.phong = value;
                                    hopDongModel.idPhong = value?.id;
                                  });
                                },
                              ),
                            ],
                          ),
                    SizedBox(height: 25),
                    !edit
                        ? TextFielWidget(
                            enabled: edit,
                            type: TextInputType.number,
                            title: 'Ngày thuê',
                            controller: TextEditingController(text: dateStart),
                          )
                        : DatePickerBox1(
                            requestDayBefore: dateEnd,
                            isTime: false,
                            label: Text(
                              'Ngày thuê',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            dateDisplay: dateStart,
                            selectedDateFunction: (day) {
                              dateStart = day;
                              setState(() {});
                            }),
                    SizedBox(height: 25),
                    !edit
                        ? TextFielWidget(
                            enabled: edit,
                            type: TextInputType.number,
                            title: 'Ngày hết hạn',
                            controller: TextEditingController(text: dateEnd),
                          )
                        : DatePickerBox1(
                            requestDayAfter: dateStart,
                            isTime: false,
                            label: Text(
                              'Ngày hết hạn',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            dateDisplay: dateEnd,
                            selectedDateFunction: (day) {
                              dateEnd = day;
                              setState(() {});
                            }),
                    SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      type: TextInputType.number,
                      title: 'Số lượng người trọ',
                      controller: numberPeople,
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
                                              List<String> listFile = hopDongModel.file!.split(",");
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext context) => ViewHopDongScreen(
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
                                        hopDongModel.file = filename;
                                        List<String> listFile = hopDongModel.file!.split(",");
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
                            listSelecet: listStatusHopDong,
                            title: 'Trạng thái hợp đồng',
                            selectedIndex: hopDongModel.status,
                            onSelect: (value) {
                              setState(() {
                                hopDongModel.status = value as int;
                              });
                            },
                          )
                        : TextFielWidget(
                            enabled: edit,
                            title: 'Trạng thái hợp đồng',
                            controller: TextEditingController(text: valueStatusHopDong(hopDongModel.status ?? -1)),
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
                                    hopDongModel.numberPeople = int.tryParse(numberPeople.text) ?? 0;
                                    _bloc.add(SuaHopDongEvent(hopDongModel: hopDongModel, dateStart: dateStart, dateEnd: dateEnd, phongModel: phongOld));
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
