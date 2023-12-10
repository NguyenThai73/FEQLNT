// ignore_for_file: prefer_const_constructors
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/apps/widgets/date-pick-time.dart';
import 'package:fe/apps/widgets/drop.search.dart';
import 'package:fe/apps/widgets/month-pick-time.dart';
import 'package:fe/apps/widgets/textfiel2.dart';
import 'package:fe/apps/widgets/toast.dart';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/views/component/loading/loading.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hoa_don/bloc/quan_ly_hoa_don_bloc.dart';
import 'package:fe/z_provider/base.url.dart';
import 'package:fe/z_provider/dich.vu.provider.dart';
import 'package:fe/z_provider/hoa.don.provider.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemHoaDon extends StatefulWidget {
  const ThemHoaDon({super.key});

  @override
  State<ThemHoaDon> createState() => _ThemHoaDonState();
}

class _ThemHoaDonState extends State<ThemHoaDon> {
  final _bloc = QuanLyHoaDonBloc();
  TextEditingController tienPhatSinh = TextEditingController(text: "0");
  TextEditingController des = TextEditingController();
  HoaDonModel hoaDonModel = HoaDonModel(status: 0, total: 0, fine: 0);
  List<int> listHopDongDaCoHoaDon = [];
  int countFile = 0;
  String? dateDisplay;

  List<TextEditingController> listInputDichVu = [];
  getListDichVu() async {
    try {
      var listDichVuGet = await DichVuProvider.getList();
      setState(() {
        hoaDonModel.listDichVu = listDichVuGet;
        hoaDonModel.listSoLuong = List<int>.generate(hoaDonModel.listDichVu!.length, (index) {
          if (hoaDonModel.listDichVu![index].donVi == 1) {
            return 1;
          } else {
            return 0;
          }
        });
        hoaDonModel.listTotalDichVu = List<int>.generate(hoaDonModel.listDichVu!.length, (index) {
          if (hoaDonModel.listDichVu![index].donVi == 1) {
            return hoaDonModel.listDichVu![index].donGia ?? 0;
          } else {
            return 0;
          }
        });
        listInputDichVu = List.generate(hoaDonModel.listDichVu!.length, (index) {
          if (hoaDonModel.listDichVu![index].donVi == 1) {
            return TextEditingController(text: "1");
          } else {
            return TextEditingController(text: "0");
          }
        });

        statusDichVu = true;
      });
      tinhDiem();
    } catch (e) {
      print("Loi: $e");
    }
  }

  tinhDiem() {
    setState(() {
      int totalDichVu = 0;
      hoaDonModel.listTotalDichVu?.forEach((element) {
        totalDichVu += element;
      });
      int tienNha = hoaDonModel.hopDong?.phong?.gia ?? 0;
      int tienPhatSinh = hoaDonModel.fine ?? 0;
      hoaDonModel.total = tienPhatSinh + totalDichVu + tienNha;
    });
  }

  bool statusDichVu = false;

  @override
  void initState() {
    super.initState();
    getListDichVu();
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
          "Thêm hoá đơn mới",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BlocConsumer<QuanLyHoaDonBloc, QuanLyHoaDonState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is QuanLyHoaDonLoading) {
              onLoading(context);
              return;
            } else if (state is ThemMoiSuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is QuanLyHoaDonError) {
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
                    MonthPickerWidget(
                      title: 'Tháng',
                      dateSelected: hoaDonModel.name,
                      onSelected: (value) async {
                        hoaDonModel.name = value;
                        if (value != null) {
                          listHopDongDaCoHoaDon = await HoaDonProvider.getListHoaDonThang(thang: value);
                        } else {
                          listHopDongDaCoHoaDon = [];
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      "Hợp đồng",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SropSearchWidget<HopDongModel>(
                      getList: HopDongProvider.getListToHoaDon(list: listHopDongDaCoHoaDon),
                      title: (HopDongModel u) => "Hợp đồng ${u.phong?.name}",
                      selected: hoaDonModel.hopDong,
                      onChange: (value) {
                        setState(() {
                          hoaDonModel.hopDong = value;
                          hoaDonModel.idHopDong = value?.id;
                        });
                        tinhDiem();
                      },
                    ),
                    SizedBox(height: 25),
                    TextFiel2Widget(
                      enabled: false,
                      type: TextInputType.number,
                      title: 'Tiền nhà',
                      controller: TextEditingController(text: formatCurrency(hoaDonModel.hopDong?.phong?.gia ?? 0)),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 25),
                    Text(
                      "Dịch vụ",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    (statusDichVu && hoaDonModel.listDichVu!.isNotEmpty)
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.5, color: Colors.grey),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0; i < hoaDonModel.listDichVu!.length; i++)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${hoaDonModel.listDichVu![i].name} ( ${valueNameDonVi(hoaDonModel.listDichVu![i].donVi ?? -1)} )",
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFiel2Widget(
                                                    enabled: (hoaDonModel.listDichVu![i].donVi != 1),
                                                    type: TextInputType.number,
                                                    title: 'Số lượng',
                                                    controller: listInputDichVu[i],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        var soluongConvert = int.tryParse(value) ?? 0;
                                                        hoaDonModel.listSoLuong![i] = soluongConvert;
                                                        var dongiaConvert = hoaDonModel.listDichVu![i].donGia ?? 0;
                                                        hoaDonModel.listTotalDichVu![i] = soluongConvert * dongiaConvert;
                                                      });
                                                      tinhDiem();
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFiel2Widget(
                                                    enabled: false,
                                                    type: TextInputType.number,
                                                    title: 'Đơn giá',
                                                    controller: TextEditingController(
                                                      text: formatCurrency2(hoaDonModel.listDichVu![i].donGia ?? 0),
                                                    ),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFiel2Widget(
                                                    enabled: false,
                                                    type: TextInputType.number,
                                                    title: 'Thành tiền',
                                                    controller: TextEditingController(
                                                      text: formatCurrency2(hoaDonModel.listTotalDichVu![i]),
                                                    ),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 25),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(),
                    const SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "File đính kèm",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5, color: Colors.grey),
                          ),
                          height: 50,
                          child: InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              onLoading(context);
                              var filename = await handleUploadFile();
                              setState(() {
                                if (filename != null) {
                                  hoaDonModel.file = filename;
                                  List<String> listFile = hoaDonModel.file!.split(",");
                                  countFile = listFile.length;
                                }
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Đã tải lên : $countFile file",
                                  style: TextStyle(fontSize: 16, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    TextFiel2Widget(
                      type: TextInputType.number,
                      title: 'Khoản phát sinh',
                      controller: tienPhatSinh,
                      onChanged: (value) {
                        setState(() {
                          hoaDonModel.fine = int.tryParse(value) ?? 0;
                        });
                        tinhDiem();
                      },
                    ),
                    const SizedBox(height: 25),
                    TextFiel2Widget(
                      maxLine: 100,
                      minLines: 3,
                      type: TextInputType.number,
                      title: 'Ghi chú',
                      controller: des,
                      onChanged: (value) {
                        hoaDonModel.description = value;
                      },
                    ),
                    SizedBox(height: 25),
                    TextFiel2Widget(
                      enabled: false,
                      type: TextInputType.number,
                      title: 'Tổng tiền',
                      controller: TextEditingController(text: formatCurrency(hoaDonModel.total ?? 0)),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 25),
                    DatePickerBox1(
                        isTime: false,
                        label: Text(
                          'Ngày đến hạn',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        dateDisplay: dateDisplay,
                        selectedDateFunction: (day) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          hoaDonModel.dueDate = day;
                        }),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              print((hoaDonModel.toMap()));
                              _bloc.add(ThemHoaDonEvent(hoaDonModel: hoaDonModel));
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
}
