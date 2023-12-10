// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:fe/views/screens/app_nguoi_tro/xem.hoa.don.user.dart';
import 'package:fe/z_provider/dich.vu.provider.dart';
import 'package:fe/z_provider/hoa.don.provider.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HoaDonNTScreen extends StatefulWidget {
  const HoaDonNTScreen({super.key});

  @override
  State<HoaDonNTScreen> createState() => _HoaDonNTScreenState();
}

class _HoaDonNTScreenState extends State<HoaDonNTScreen> {
  final ScrollController _scrollController = ScrollController();
  NguoiDungModel myAccount = NguoiDungModel();
  NguoiDungModel admin = NguoiDungModel();
  List<HoaDonModel> listHoaDon = [];
  Uri launchUri = Uri(
    scheme: 'tel',
    path: "0987654321",
  );
  getData() async {
    await getProfile();
    await getHoaDon();
  }

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    if (id != null) {
      var nguoiDungModelGet = await NguoiDungProvider.getUserById(id: id);
      var admin = await NguoiDungProvider.getAdmin();
      myAccount = nguoiDungModelGet;
      admin = admin;
      launchUri = Uri(
        scheme: 'tel',
        path: admin.sdt ?? "0987654321",
      );
    }
  }

  getHoaDon() async {
    var lisHoaDon = await HoaDonProvider.getListHoaDonTheoHopDong(idHopDong: myAccount.idHopDong ?? 0);
    setState(() {
      listHoaDon = lisHoaDon;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Row(),
        title: Center(
          child: Text(
            "Hoá đơn",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await launchUrl(launchUri);
            },
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: listHoaDon.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 135,
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
                        listHoaDon[index].listDichVu = [];
                        listHoaDon[index].listSoLuong = [];
                        listHoaDon[index].listTotalDichVu = [];
                        var dataDecode = jsonDecode(listHoaDon[index].data.toString()) as Map<String, dynamic>;
                        for (var element in dataDecode.entries) {
                          DichVuModel itemDichVu = await DichVuProvider.getById(element.key);
                          int soluongItem = int.tryParse(element.value.toString()) ?? 0;
                          int total = itemDichVu.donGia ?? 0 * soluongItem;
                          listHoaDon[index].listDichVu?.add(itemDichVu);
                          listHoaDon[index].listSoLuong?.add(soluongItem);
                          listHoaDon[index].listTotalDichVu?.add(total);
                        }
                        await Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => XemHoaDonUer(
                              hoaDonModel: listHoaDon[index],
                              callback: (value) {
                                if (value != null) {
                                  setState(() {
                                    listHoaDon[index] = value;
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
                            Icons.paid,
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
                                  "Hoá đơn tháng ${listHoaDon[index].name != null ? DateFormat('MM-yyyy').format(DateTime.parse(listHoaDon[index].name ?? "").toLocal()) : ""}",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Phòng: ${listHoaDon[index].hopDong?.phong?.name ?? ""}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Trạng thái: ${valueStatusHoaDon(listHoaDon[index].status ?? -1)}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: colorsStatusHoaDon(listHoaDon[index].status ?? -1), fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Tổng tiền: ${formatCurrency(listHoaDon[index].total ?? 0)}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Ngày hết hạn: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(listHoaDon[index].dueDate!).toLocal())}",
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
            )
          ],
        ),
      ),
    );
  }
}
