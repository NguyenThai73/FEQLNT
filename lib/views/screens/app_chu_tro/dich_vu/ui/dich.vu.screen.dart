// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dich_vu_bloc.dart';
import 'package:animation_list/animation_list.dart';

import 'sua.dart';
import 'them.dart';

class DichVuScreen extends StatefulWidget {
  const DichVuScreen({super.key});

  @override
  State<DichVuScreen> createState() => _DichVuScreenState();
}

class _DichVuScreenState extends State<DichVuScreen> {
  final _bloc = DichVuBloc();
  List<DichVuModel> listDichVu = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetLisEvent());
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
            "Dịch vụ",
            style: TextStyle(color: Colors.white),
          )),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<DichVuBloc, DichVuState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is DichVuLoading) {
                onLoading(context);
                return;
              } else if (state is DichVuSuccess) {
                Navigator.pop(context);
                listDichVu = state.list;
              } else if (state is DichVuError) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: AnimationList(
                  children: listDichVu.map(
                    (element) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 100,
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
                                builder: (BuildContext context) => EditScreen(
                                  dichVuModel: element,
                                ),
                              ),
                            );
                            _bloc.add(GetLisEvent());
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.dry_cleaning,
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
                                      "${element.donGia} ${valueNameDonVi(element.donVi ?? 0)}",
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
                  builder: (BuildContext context) => const AddScreen(),
                ),
              );
              _bloc.add(GetLisEvent());
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
