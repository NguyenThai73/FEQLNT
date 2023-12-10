// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/ui/them.hop.dong.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/ui/thong.tin.hop.dong.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/quan_ly_hop_dong_bloc.dart';

class HopDongScreen extends StatefulWidget {
  final bool showFilter;
  const HopDongScreen({super.key, required this.showFilter});

  @override
  State<HopDongScreen> createState() => _HopDongScreenState();
}

class _HopDongScreenState extends State<HopDongScreen> {
  final ScrollController _scrollController = ScrollController();
  final _bloc = QuanLyHopDongBloc();
  List<HopDongModel> listHopDong = [];
  int numberPage = 0;

  PhongModel? selectPhong = PhongModel(name: "Tất cả");
  int selectedStatus = 1;
  @override
  void initState() {
    super.initState();
    _bloc.add(GetListHopDongEvent(selectedStatus: selectedStatus, selectPhong: selectPhong, numberPage: numberPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuanLyHopDongBloc, QuanLyHopDongState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is QuanLyHopDongLoading) {
            onLoading(context);
            return;
          } else if (state is QuanLyHopDongSuccess) {
            Navigator.pop(context);
            listHopDong.addAll(state.list);
          } else if (state is QuanLyHopDongError) {
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
                    _bloc.add(GetListHopDongEvent(selectedStatus: selectedStatus, selectPhong: selectPhong, numberPage: numberPage));
                  } else if (scrollNotification is ScrollEndNotification && _scrollController.position.extentBefore == 0) {
                    setState(() {
                      listHopDong = [];
                      numberPage = 0;
                    });
                    _bloc.add(GetListHopDongEvent(selectedStatus: selectedStatus, selectPhong: selectPhong, numberPage: numberPage));
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
                                    Expanded(flex: 2, child: Text("Phòng:", style: TextStyle(fontSize: 18))),
                                    Expanded(
                                      flex: 5,
                                      child: SropSearchWidget<PhongModel>(
                                        getList: PhongProvider.getListFilter(),
                                        title: (PhongModel u) => u.name!,
                                        selected: selectPhong,
                                        onChange: (value) {
                                          setState(() {
                                            selectPhong = value;
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
                                        listSelecet: listStatusHopDongFilter,
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
                                            listHopDong = [];
                                          });
                                          _bloc.add(GetListHopDongEvent(selectedStatus: selectedStatus, selectPhong: selectPhong, numberPage: 0));
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
                        itemCount: listHopDong.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 120,
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
                                    builder: (BuildContext context) => ThongTinHopDong(
                                      hopDongModel: listHopDong[index],
                                      callBack: (value) {
                                        if (value != null) {
                                          setState(() {
                                            listHopDong[index] = value;
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
                                  Icon(
                                    Icons.article,
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
                                          "Hơp đồng ${listHopDong[index].phong?.name ?? ""} (${DateFormat('MM-yyyy').format(DateTime.parse(listHopDong[index].dateStart!).toLocal())})",
                                          style: TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Trạng thái: ${valueStatusHopDong(listHopDong[index].status ?? -1)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(color: (listHopDong[index].status == 1) ? Colors.green : Colors.red),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Ngày thuê: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listHopDong[index].dateStart!).toLocal())}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Ngày hết hạn: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listHopDong[index].dateEnd!).toLocal())}",
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
                builder: (BuildContext context) => const ThemHopDong(),
              ),
            );
            setState(() {
              listHopDong = [];
            });
            _bloc.add(GetListHopDongEvent(selectedStatus: selectedStatus, selectPhong: selectPhong, numberPage: 0));
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
