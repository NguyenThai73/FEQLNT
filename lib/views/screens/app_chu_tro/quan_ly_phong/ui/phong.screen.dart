// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:animation_list/animation_list.dart';
import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quan_ly_phong_bloc.dart';
import 'them.phong.dart';
import 'xem.phong.dart';

class QuanLyPhongScreen extends StatefulWidget {
  const QuanLyPhongScreen({super.key});

  @override
  State<QuanLyPhongScreen> createState() => _QuanLyPhongScreenState();
}

class _QuanLyPhongScreenState extends State<QuanLyPhongScreen> {
  final _bloc = QuanLyPhongBloc();
  List<PhongModel> listPhong = [];
  bool showFilter = false;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetLisPhongEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
           leading: Row(),
          backgroundColor: Colors.blue,
          title: const Center(
              child: Text(
            "Phòng",
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
        body: BlocConsumer<QuanLyPhongBloc, QuanLyPhongState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is QuanLyPhongLoading) {
                onLoading(context);
                return;
              } else if (state is QuanLyPhongSuccess) {
                Navigator.pop(context);
                listPhong = state.listPhong;
              } else if (state is QuanLyPhongError) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: AnimationList(
                  children: listPhong.map(
                    (element) {
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
                                builder: (BuildContext context) => XemPhongScreen(
                                  phongModel: element,
                                ),
                              ),
                            );
                            _bloc.add(GetLisPhongEvent());
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.room_service,
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
                                      element.name ?? "",
                                      style: TextStyle(fontSize: 22),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Nhà: ${element.nha?.name}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Giá phòng: ${formatCurrency(element.gia ?? 0)}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "Trạng thái: ${valueStatusPhongModel(element.status!)}",
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
                  ).toList(),
                ),
              );
            }),
        floatingActionButton: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue),
          child: InkWell(
            onTap: () async {
              await Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ThemPhongScreen(),
                ),
              );
              _bloc.add(GetLisPhongEvent());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
