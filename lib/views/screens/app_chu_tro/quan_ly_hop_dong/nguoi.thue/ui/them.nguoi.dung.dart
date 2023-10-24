// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/nguoi.thue/bloc/quan_ly_nguoi_dung_bloc.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemNguoiDung extends StatefulWidget {
  const ThemNguoiDung({super.key});

  @override
  State<ThemNguoiDung> createState() => _ThemNguoiDungState();
}

class _ThemNguoiDungState extends State<ThemNguoiDung> {
  final _bloc = QuanLyNguoiDungBloc();
  TextEditingController username = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController namSinh = TextEditingController();
  TextEditingController sdt = TextEditingController();

  NguoiDungModel nguoiDungModel = NguoiDungModel(status: 1);
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
          "Thêm hợp người dùng",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BlocConsumer<QuanLyNguoiDungBloc, QuanLyNguoiDungState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyNguoiDungLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
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
                    SizedBox(height: 25),
                    TextFielWidget(
                      title: 'Tên đăng nhập',
                      controller: username,
                    ),
                    SizedBox(height: 25),
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
                              nguoiDungModel.username = username.text;
                              nguoiDungModel.fullName = fullName.text;
                              nguoiDungModel.namSinh = namSinh.text;
                              nguoiDungModel.sdt = sdt.text;
                              _bloc.add(ThemNguoiDungEvent(nguoiDungModel: nguoiDungModel));
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
