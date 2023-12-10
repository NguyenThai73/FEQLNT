// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_nha/ui/sua.nha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quan_ly_nha_bloc.dart';
import 'package:animation_list/animation_list.dart';

import 'them.nha.dart';

class QuanLyNhaScreen extends StatefulWidget {
  const QuanLyNhaScreen({super.key});

  @override
  State<QuanLyNhaScreen> createState() => _QuanLyNhaScreenState();
}

class _QuanLyNhaScreenState extends State<QuanLyNhaScreen> {
  final _bloc = QuanLyNhaBloc();
  List<NhaModel> listNha = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetLisNhaEvent());
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
            "Nhà",
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: BlocConsumer<QuanLyNhaBloc, QuanLyNhaState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is QuanLyNhaLoading) {
                onLoading(context);
                return;
              } else if (state is QuanLyNhaSuccess) {
                Navigator.pop(context);
                listNha = state.list;
              } else if (state is QuanLyNhaError) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: AnimationList(
                  children: listNha.map(
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
                                builder: (BuildContext context) => SuaNhaScreen(
                                  nhaModel: element,
                                ),
                              ),
                            );
                            _bloc.add(GetLisNhaEvent());
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.home,
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
                                      element.address ?? "",
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
                  builder: (BuildContext context) => const AddNhaScreen(),
                ),
              );
              _bloc.add(GetLisNhaEvent());
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
