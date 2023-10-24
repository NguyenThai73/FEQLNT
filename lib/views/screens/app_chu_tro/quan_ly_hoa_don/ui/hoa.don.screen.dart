// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/month-pick-time.dart';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hoa_don/bloc/quan_ly_hoa_don_bloc.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hoa_don/ui/xem.hoa.don.dart';
import 'package:fe/z_provider/dich.vu.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'them.moi.hoa.don.dart';

class HoaDonScreen extends StatefulWidget {
  const HoaDonScreen({super.key});

  @override
  State<HoaDonScreen> createState() => _HoaDonScreenState();
}

class _HoaDonScreenState extends State<HoaDonScreen> {
  final ScrollController _scrollController = ScrollController();
  bool showFilter = false;
  final _bloc = QuanLyHoaDonBloc();
  List<HoaDonModel> listHoaDon = [];
  int numberPage = 0;
  String? selectDate;

  PhongModel? selectPhong = PhongModel(name: "Tất cả");
  int selectedStatus = 1;
  @override
  void initState() {
    super.initState();
    _bloc.add(GetListHoaDonEvent(selectedStatus: selectedStatus, numberPage: numberPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Row(),
        title: const Center(
            child: Text(
          "Quản lý hoá đơn",
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showFilter = !showFilter;
                });
              },
              icon: Icon(
                !showFilter ? Icons.filter_alt : Icons.filter_alt_off,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocConsumer<QuanLyHoaDonBloc, QuanLyHoaDonState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is QuanLyHoaDonLoading) {
            onLoading(context);
            return;
          } else if (state is QuanLyHoaDonSuccess) {
            Navigator.pop(context);
            listHoaDon.addAll(state.list);
          } else if (state is QuanLyHoaDonError) {
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
                    _bloc.add(GetListHoaDonEvent(selectedStatus: selectedStatus, numberPage: numberPage));
                  } else if (scrollNotification is ScrollEndNotification && _scrollController.position.extentBefore == 0) {
                    setState(() {
                      listHoaDon = [];
                      numberPage = 0;
                    });
                    _bloc.add(GetListHoaDonEvent(selectedStatus: selectedStatus, numberPage: numberPage));
                  }
                  return true;
                },
                child: Column(
                  children: [
                    showFilter
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
                                    Expanded(flex: 2, child: Text("Tháng:", style: TextStyle(fontSize: 18))),
                                    Expanded(
                                      flex: 5,
                                      child: MonthPickerWidget(
                                        title: 'Tháng',
                                        noTitle: true,
                                        dateSelected: selectDate,
                                        onSelected: (value) async {
                                          setState(() {
                                            selectDate = value;
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
                                        listSelecet: listStatusHoaDonFilter,
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
                                            listHoaDon = [];
                                          });
                                          _bloc.add(GetListHoaDonEvent(selectedStatus: selectedStatus, numberPage: 0));
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
                        itemCount: listHoaDon.length,
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
                                listHoaDon[index].listDichVu = [];
                                listHoaDon[index].listSoLuong = [];
                                listHoaDon[index].listTotalDichVu = [];
                                var dataDecode = jsonDecode(listHoaDon[index].data.toString()) as Map<String, dynamic>;
                                for (var element in dataDecode.entries) {
                                   DichVuModel itemDichVu = await DichVuProvider.getById(element.key);
                                    int soluongItem = int.tryParse(element.value.toString()) ?? 0;
                                    int total = itemDichVu.donGia ?? 0 * soluongItem;
                                    listHoaDon[index].listDichVu?.add(itemDichVu);
                                    listHoaDon[index].listSoLuong?.add(soluongItem);
                                    listHoaDon[index].listTotalDichVu?.add(total);
                                }
                                await Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => XemHoaDon(
                                      hoaDonModel: listHoaDon[index],
                                      // callBack: (value) {
                                      //   if (value != null) {
                                      //     setState(() {
                                      //       listHoaDon[index] = value;
                                      //     });
                                      //   }
                                      // },
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.paid,
                                    size: 45,
                                    color: const Color.fromARGB(255, 75, 75, 75),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hoá đơn tháng ${listHoaDon[index].name != null ? DateFormat('MM-yyyy').format(DateTime.parse(listHoaDon[index].name ?? "").toLocal()) : ""}",
                                          style: TextStyle(fontSize: 22),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Trạng thái: ${valueStatusHoaDon(listHoaDon[index].status ?? -1)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(color: (listHoaDon[index].status == 1) ? Colors.green : Colors.red),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Tổng tiền: ${formatCurrency(listHoaDon[index].total ?? 0)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Ngày hết hạn: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listHoaDon[index].dueDate!).toLocal())}",
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
                builder: (BuildContext context) => const ThemHoaDon(),
              ),
            );
            setState(() {
              listHoaDon = [];
            });
            _bloc.add(GetListHoaDonEvent(selectedStatus: selectedStatus, numberPage: numberPage));
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
