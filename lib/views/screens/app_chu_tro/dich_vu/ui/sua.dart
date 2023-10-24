// ignore_for_file: prefer_const_constructors

import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/dich_vu/bloc/dich_vu_bloc.dart';
import 'package:fe/z_provider/khu.tro.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EditScreen extends StatefulWidget {
  final DichVuModel dichVuModel;
  const EditScreen({super.key, required this.dichVuModel});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController donGia = TextEditingController(text: "0");
  NhaModel? selectedNha;
  final _bloc = DichVuBloc();
  Map<int, String> listDonVi = {
    0: "VNĐ / người",
    1: "VNĐ / phòng",
    2: "VNĐ / số lượng",
  };
  DichVuModel dichVuModel = DichVuModel(donVi: 0);

  @override
  void initState() {
    super.initState();
    dichVuModel = widget.dichVuModel;
    name.text = dichVuModel.name ?? "";
    donGia.text = dichVuModel.donGia.toString();
    selectedNha = dichVuModel.nha;
  }

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
        title: const Text(
          "Thông tin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<DichVuBloc, DichVuState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is DichVuLoading) {
              onLoading(context);
              return;
            } else if (state is SuaSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is DichVuError) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFielWidget(
                      title: 'Tên',
                      controller: name,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Nhà",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1.5, color: Colors.grey),
                            ),
                            height: 50,
                            child: DropdownSearch<NhaModel>(
                              popupProps: PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  constraints: const BoxConstraints.tightFor(
                                    width: 300,
                                    height: 40,
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 14, bottom: 14),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                    borderSide: BorderSide(color: Colors.white, width: 0),
                                  ),
                                  hintText: "",
                                  hintMaxLines: 1,
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(color: Colors.white, width: 0),
                                  ),
                                ),
                              ),
                              asyncItems: (String? filter) => KhuTroProvider.getListNha(),
                              itemAsString: (NhaModel u) => u.name!,
                              selectedItem: selectedNha,
                              onChanged: (value) {
                                setState(() {
                                  selectedNha = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    TextFielWidget(
                      title: 'Đơn giá',
                      type: TextInputType.number,
                      controller: donGia,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Đơn vị",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1.5, color: Colors.grey),
                            ),
                            height: 50,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                items: listDonVi.entries.map((item) => DropdownMenuItem<int>(value: item.key, child: Text(item.value))).toList(),
                                value: dichVuModel.donVi,
                                onChanged: (value) {
                                  setState(() {
                                    dichVuModel.donVi = value as int;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                              dichVuModel.name = name.text;
                              dichVuModel.idNha = selectedNha?.id;
                              dichVuModel.donGia = int.tryParse(donGia.text);
                              _bloc.add(SuaEvent(dichVuModel: dichVuModel));
                            },
                            child: const Center(
                              child: Text(
                                "Cập nhật",
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
