// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/apps/widgets/drop.down.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/textfiel.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/nha_model/nha.model.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/models/phong/phong.vat.chat.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_phong/bloc/quan_ly_phong_bloc.dart';
import 'package:fe/z_provider/khu.tro.provider.dart';
import 'package:fe/z_provider/phong.vat.chat.provider.dart';
import 'package:fe/z_provider/vat.chat.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class XemPhongScreen extends StatefulWidget {
  final PhongModel phongModel;
  const XemPhongScreen({super.key, required this.phongModel});

  @override
  State<XemPhongScreen> createState() => _XemPhongScreenState();
}

class _XemPhongScreenState extends State<XemPhongScreen> {
  final _bloc = QuanLyPhongBloc();
  List<PhongVatChat> listVatChat = [];
  List<PhongVatChat> listVatChatRemovw = [];
  List<PhongVatChat> listVatChatNhap = [];

  bool edit = false;
  TextEditingController name = TextEditingController();
  TextEditingController nha = TextEditingController();
  TextEditingController gia = TextEditingController();
  TextEditingController status = TextEditingController();
  NhaModel? selectedNha;
  PhongModel phongModel = PhongModel();

  @override
  void initState() {
    super.initState();
    phongModel = widget.phongModel;
    _bloc.add(GetListPhongVatChat(idPhong: phongModel.id ?? 0));
    name.text = phongModel.name ?? "";
    gia.text = formatCurrency(phongModel.gia ?? 0);
    nha.text = phongModel.nha?.name ?? "";
    status.text = valueStatusPhongModel(phongModel.status ?? -1);
    selectedNha = phongModel.nha;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Row(),
        title: Center(
            child: Text(
          edit ? "Cập nhật" : "Thông tin chi tiết",
          style: TextStyle(color: Colors.white),
        )),
        actions: [],
      ),
      body: BlocConsumer<QuanLyPhongBloc, QuanLyPhongState>(
          buildWhen: (previous, current) {
            return previous.props != current.props;
          },
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyPhongLoading) {
              onLoading(context);
              return;
            } else if (state is GetListPhongVatChatSucces) {
              Navigator.pop(context);
              listVatChatNhap = state.listVatChat;
              listVatChat = state.listVatChat;
              gia.text = "${phongModel.gia ?? 0}";
              if (listVatChatNhap.isEmpty) {
                listVatChatNhap.add(PhongVatChat(vatChat: VatChat()));
              }
            } else if (state is SuaPhongSuccess) {
              Navigator.pop(context);
              showToast(
                context: context,
                msg: "Cập nhật thành công",
                color: const Color.fromARGB(255, 120, 255, 125),
                icon: const Icon(Icons.done),
              );
              _bloc.add(GetListPhongVatChat(idPhong: phongModel.id ?? 0));
              gia.text = formatCurrency(phongModel.gia ?? 0);
              nha.text = phongModel.nha?.name ?? "";
              status.text = valueStatusPhongModel(phongModel.status ?? -1);
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
                      enabled: edit,
                    ),
                    const SizedBox(height: 25),
                    edit
                        ? Text(
                            "Nhà",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        : Row(),
                    edit
                        ? SropSearchWidget<NhaModel>(
                            getList: KhuTroProvider.getListNha(),
                            title: (NhaModel u) => u.name!,
                            selected: selectedNha,
                            onChange: (value) {
                              setState(() {
                                selectedNha = value!;
                              });
                            },
                          )
                        : TextFielWidget(
                            title: 'Nhà',
                            controller: nha,
                            enabled: edit,
                          ),
                    const SizedBox(height: 25),
                    TextFielWidget(
                      enabled: edit,
                      type: TextInputType.number,
                      title: 'Giá phòng (VNĐ)',
                      controller: gia,
                    ),
                    const SizedBox(height: 25),
                    edit
                        ? DropDownWidget(
                            listSelecet: listStatusPhong,
                            title: 'Trạng thái phòng',
                            selectedIndex: phongModel.status,
                            onSelect: (value) {
                              setState(() {
                                phongModel.status = value as int;
                              });
                            },
                          )
                        : TextFielWidget(
                            enabled: edit,
                            title: 'Trạng thái phòng',
                            controller: status,
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
                            child: edit
                                ? Column(
                                    children: [
                                      for (var i = 0; i < listVatChatNhap.length; i++)
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
                                                  selected: listVatChatNhap[i].vatChat,
                                                  onChange: (value) {
                                                    setState(() {
                                                      listVatChatNhap[i].vatChat = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: (i == 0 && listVatChatNhap.length == 1)
                                                    ? Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  listVatChatNhap.add(PhongVatChat(vatChat: VatChat()));
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors.blue,
                                                              )),
                                                        ],
                                                      )
                                                    : (i == 0 && listVatChatNhap.length > 1)
                                                        ? Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      listVatChatRemovw.add(listVatChat[i]);
                                                                      listVatChatNhap.removeAt(i);
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    color: Colors.blue,
                                                                  )),
                                                            ],
                                                          )
                                                        : (i == listVatChatNhap.length - 1)
                                                            ? Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  InkWell(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          listVatChatRemovw.add(listVatChat[i]);
                                                                          listVatChatNhap.removeAt(i);
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
                                                                          listVatChatNhap.add(PhongVatChat(vatChat: VatChat()));
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
                                                                          listVatChatRemovw.add(listVatChat[i]);
                                                                          listVatChatNhap.removeAt(i);
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
                                  )
                                : (listVatChatNhap.isNotEmpty && listVatChatNhap.first.id != null)
                                    ? Column(
                                        children: [
                                          for (var element in listVatChat)
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: TextFielWidget(
                                                        noTitle: true,
                                                        enabled: false,
                                                        controller: TextEditingController(text: element.vatChat?.name ?? ""),
                                                        title: '',
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                        flex: 4,
                                                        child: DropDownWidget(
                                                          background: (element.status == 0) ? const Color.fromARGB(255, 255, 160, 154) : const Color.fromARGB(255, 132, 199, 255),
                                                          noTitle: true,
                                                          listSelecet: listStatusPhongVatChat,
                                                          onSelect: (value) async {
                                                            setState(() {
                                                              element.status = value;
                                                            });
                                                            onLoading(context);
                                                            await PhongVatChatProvider.sua(element);
                                                            Navigator.pop(context);
                                                          },
                                                          selectedIndex: element.status,
                                                          title: '',
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            )
                                        ],
                                      )
                                    : Container(
                                        height: 40,
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Center(child: Text("Không có cơ sở vật chất")),
                                      ),
                          ),
                        ),
                      ],
                    ),
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
