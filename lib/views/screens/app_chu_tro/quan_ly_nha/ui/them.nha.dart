import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_nha/bloc/quan_ly_nha_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNhaScreen extends StatefulWidget {
  const AddNhaScreen({super.key});

  @override
  State<AddNhaScreen> createState() => _AddNhaScreenState();
}

class _AddNhaScreenState extends State<AddNhaScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController mota = TextEditingController();
  final _bloc = QuanLyNhaBloc();
  NhaModel nhaModel = NhaModel();
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
          "Thêm Nhà",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<QuanLyNhaBloc, QuanLyNhaState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyNhaLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
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
                          nhaModel = NhaModel(name: name.text, address: adress.text, moTa: mota.text,status: 1);
                          _bloc.add(ThemNhaEvent(nhaModel: nhaModel));
                        },
                        child: const Center(
                          child: Text(
                            "Tạo mới",
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
