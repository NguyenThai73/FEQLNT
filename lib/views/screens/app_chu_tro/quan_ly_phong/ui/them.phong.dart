// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/z_provider/khu.tro.provider.dart';
import 'package:fe/z_provider/vat.chat.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quan_ly_phong_bloc.dart';

class ThemPhongScreen extends StatefulWidget {
  const ThemPhongScreen({super.key});

  @override
  State<ThemPhongScreen> createState() => _ThemPhongScreenState();
}

class _ThemPhongScreenState extends State<ThemPhongScreen> {
  final _bloc = QuanLyPhongBloc();
  TextEditingController name = TextEditingController();
  TextEditingController gia = TextEditingController(text: "0");
  NhaModel? selectedNha;
  PhongModel phongModel = PhongModel(status: 1);
  List<VatChat> listVatChat = [VatChat()];

  @override
  void initState() {
    super.initState();
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
        title: const Center(
            child: Text(
          "Thêm mới",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BlocConsumer<QuanLyPhongBloc, QuanLyPhongState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyPhongLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Thêm mới thành công",
                color: const Color.fromARGB(255, 120, 255, 125),
                icon: const Icon(Icons.done),
              );
            } else if (state is QuanLyPhongError) {
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
                    TextFielWidget(
                      title: 'Tên phòng',
                      controller: name,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Nhà",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SropSearchWidget<NhaModel>(
                      getList: KhuTroProvider.getListNha(),
                      title: (NhaModel u) => u.name!,
                      selected: selectedNha,
                      onChange: (value) {
                        setState(() {
                          selectedNha = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 25),
                    TextFielWidget(
                      type: TextInputType.number,
                      title: 'Giá phòng (VNĐ)',
                      controller: gia,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Cơ sở vật chất",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 20, left: 10, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1.5, color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                for (var i = 0; i < listVatChat.length; i++)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: SropSearchWidget<VatChat>(
                                            getList: VatChatProvider.getList(),
                                            title: (VatChat u) => u.name ?? "",
                                            selected: listVatChat[i],
                                            onChange: (value) {
                                              setState(() {
                                                listVatChat[i] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: (i == 0 && listVatChat.length == 1)
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            listVatChat.add(VatChat());
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.blue,
                                                        )),
                                                  ],
                                                )
                                              : (i == 0 && listVatChat.length > 1)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                listVatChat.removeAt(i);
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: Colors.blue,
                                                            )),
                                                      ],
                                                    )
                                                  : (i == listVatChat.length - 1)
                                                      ? Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    listVatChat.removeAt(i);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors.blue,
                                                                )),
                                                            SizedBox(width: 5),
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    listVatChat.add(VatChat());
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors.blue,
                                                                ))
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    listVatChat.removeAt(i);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors.blue,
                                                                )),
                                                          ],
                                                        ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              phongModel.name = name.text;
                              phongModel.idNha = selectedNha?.id;
                              phongModel.gia = int.tryParse(gia.text);
                              _bloc.add(ThemMoiPhong(phongModel: phongModel, listVatChat: listVatChat));
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

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
