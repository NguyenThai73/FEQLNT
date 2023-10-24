// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/bloc/quan_ly_hop_dong_bloc.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemHopDong extends StatefulWidget {
  const ThemHopDong({super.key});

  @override
  State<ThemHopDong> createState() => _ThemHopDongState();
}

class _ThemHopDongState extends State<ThemHopDong> {
  final _bloc = QuanLyHopDongBloc();
  TextEditingController numberPeople = TextEditingController(text: "0");
  HopDongModel hopDongModel = HopDongModel(status: 1);
  int countFile = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Center(
            child: Text(
          "Thêm hợp đồng mới",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BlocConsumer<QuanLyHopDongBloc, QuanLyHopDongState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyHopDongLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
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
                    SizedBox(height: 25),
                    DatePickerBox1(
                        requestDayBefore: hopDongModel.dateEnd,
                        isTime: false,
                        label: Text(
                          'Ngày thuê',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        dateDisplay: hopDongModel.dateStart,
                        selectedDateFunction: (day) {
                          hopDongModel.dateStart = day;
                          setState(() {});
                        }),
                    SizedBox(height: 25),
                    DatePickerBox1(
                        requestDayAfter: hopDongModel.dateStart,
                        isTime: false,
                        label: Text(
                          'Ngày hết hạn',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        dateDisplay: hopDongModel.dateEnd,
                        selectedDateFunction: (day) {
                          hopDongModel.dateEnd = day;
                          setState(() {});
                        }),
                    SizedBox(height: 25),
                    TextFielWidget(
                      type: TextInputType.number,
                      title: 'Số lượng người trọ',
                      controller: numberPeople,
                    ),
                    SizedBox(height: 25),
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
                              hopDongModel.numberPeople = int.tryParse(numberPeople.text) ?? 0;
                              _bloc.add(ThemHopDongEvent(hopDongModel: hopDongModel));
                            },
                            child: const Center(
                              child: Text(
                                "Tạo mới",
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
          }),
    );
  }
}
