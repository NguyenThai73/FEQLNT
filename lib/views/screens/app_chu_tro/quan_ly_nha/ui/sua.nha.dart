import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_nha/bloc/quan_ly_nha_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuaNhaScreen extends StatefulWidget {
  final NhaModel nhaModel;
  const SuaNhaScreen({super.key, required this.nhaModel});

  @override
  State<SuaNhaScreen> createState() => _SuaNhaScreenState();
}

class _SuaNhaScreenState extends State<SuaNhaScreen> {
  NhaModel nhaModel = NhaModel();
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController mota = TextEditingController();
  final _bloc = QuanLyNhaBloc();
  @override
  void initState() {
    super.initState();
    nhaModel = widget.nhaModel;
    name.text = nhaModel.name ?? "";
    adress.text = nhaModel.address ?? "";
    mota.text = nhaModel.moTa ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
        title: const Text(
          "Thông tin nhà",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<QuanLyNhaBloc, QuanLyNhaState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyNhaLoading) {
              onLoading(context);
              return;
            } else if (state is SuaSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is QuanLyNhaError) {
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFielWidget(
                      title: 'Tên',
                      controller: name,
                    ),
                    const SizedBox(height: 25),
                    TextFielWidget(
                      title: 'Địa chỉ',
                      controller: adress,
                    ),
                    const SizedBox(height: 25),
                    TextFielWidget(
                      title: 'Mô tả',
                      controller: mota,
                      maxLine: 200,
                      minLines: 5,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () async {
                          nhaModel.name = name.text;
                          nhaModel.address = adress.text;
                          nhaModel.moTa = mota.text;
                          _bloc.add(SuaNhaEvent(nhaModel: nhaModel));
                        },
                        child: const Center(
                          child: Text(
                            "Cập nhật",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
