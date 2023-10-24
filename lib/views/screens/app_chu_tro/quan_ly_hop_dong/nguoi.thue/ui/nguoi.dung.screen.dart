// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/quan_ly_nguoi_dung_bloc.dart';
import 'them.nguoi.dung.dart';
import 'thong.tin.nguoi.dung.dart';

class NguoiDungScreen extends StatefulWidget {
  final bool showFilter;
  const NguoiDungScreen({super.key, required this.showFilter});

  @override
  State<NguoiDungScreen> createState() => _NguoiDungScreenState();
}

class _NguoiDungScreenState extends State<NguoiDungScreen> {
  final ScrollController _scrollController = ScrollController();
  final _bloc = QuanLyNguoiDungBloc();
  List<NguoiDungModel> listNguoiDung = [];
  int numberPage = 0;

  HopDongModel? selectHopDong = HopDongModel(phong: PhongModel(name: "Tất cả"));
  int selectedStatus = 1;
  @override
  void initState() {
    super.initState();
    _bloc.add(GetListNguoiDungEvent(selectedStatus: selectedStatus, hopDongModel: selectHopDong, numberPage: numberPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuanLyNguoiDungBloc, QuanLyNguoiDungState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is QuanLyNguoiDungLoading) {
            onLoading(context);
            return;
          } else if (state is QuanLyNguoiDungSuccess) {
            Navigator.pop(context);
            listNguoiDung.addAll(state.list);
          } else if (state is QuanLyNguoiDungError) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
                    numberPage += 1;
                    _bloc.add(GetListNguoiDungEvent(selectedStatus: selectedStatus, hopDongModel: selectHopDong, numberPage: numberPage));
                  } else if (scrollNotification is ScrollEndNotification && _scrollController.position.extentBefore == 0) {
                    setState(() {
                      listNguoiDung = [];
                      numberPage = 0;
                    });
                    _bloc.add(GetListNguoiDungEvent(selectedStatus: selectedStatus, hopDongModel: selectHopDong, numberPage: numberPage));
                  }
                  return true;
                },
                child: Column(
                  children: [
                    widget.showFilter
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: Color.fromARGB(255, 175, 175, 175)),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),

                                  blurRadius: 8,
                                  offset: const Offset(3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(flex: 2, child: Text("Hợp đồng:", style: TextStyle(fontSize: 18))),
                                    Expanded(
                                      flex: 5,
                                      child: SropSearchWidget<HopDongModel>(
                                        getList: HopDongProvider.getListAll(),
                                        title: (HopDongModel u) => u.phong!.name!,
                                        selected: selectHopDong,
                                        onChange: (value) {
                                          setState(() {
                                            selectHopDong = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(flex: 2, child: Text("Trạng thái:", style: TextStyle(fontSize: 18))),
                                    Expanded(
                                      flex: 5,
                                      child: DropDownWidget(
                                        title: "",
                                        listSelecet: listStatusNguoiDungFilter,
                                        noTitle: true,
                                        selectedIndex: selectedStatus,
                                        onSelect: (value) {
                                          setState(() {
                                            selectedStatus = value as int;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 125,
                                      height: 50,
                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(25)),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            listNguoiDung = [];
                                          });
                                          _bloc.add(GetListNguoiDungEvent(selectedStatus: selectedStatus, hopDongModel: selectHopDong, numberPage: 0));
                                        },
                                        child: Center(
                                          child: Text(
                                            "Tìm kiếm",
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : Row(),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: listNguoiDung.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2, color: const Color.fromARGB(255, 105, 188, 255)),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: const Offset(3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => ThongTinNguoiDung(
                                      nguoiDungModel: listNguoiDung[index],
                                      callBack: (value) {
                                        if (value != null) {
                                          setState(() {
                                            listNguoiDung[index] = value;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  (listNguoiDung[index].avatar != null)
                                      ? Image.network(
                                          "$baseUrl/api/files/${listNguoiDung[index].avatar}",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 50,
                                          color: const Color.fromARGB(255, 75, 75, 75),
                                        ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${listNguoiDung[index].fullName ?? ""} (${listNguoiDung[index].fileCccd != null ? "Đã tải CCCD" : "Chưa tải CCCD"})",
                                          style: TextStyle(fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Phòng: ${listNguoiDung[index].hopDong?.phong?.name}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Ngày thuê: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listNguoiDung[index].hopDong!.dateStart!).toLocal())}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Ngày hết hạn: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listNguoiDung[index].hopDong!.dateEnd!).toLocal())}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Số điện thoại: ${listNguoiDung[index].sdt!}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ]),
        child: InkWell(
          onTap: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ThemNguoiDung(),
              ),
            );
            setState(() {
              listNguoiDung = [];
            });
            _bloc.add(GetListNguoiDungEvent(selectedStatus: selectedStatus, hopDongModel: selectHopDong, numberPage: 0));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
