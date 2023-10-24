import 'dart:convert';

import 'package:fe/apps/const/map.status.dart';
import 'package:fe/apps/funtion/format.dart';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hoa_don/ui/xem.hoa.don.dart';
import 'package:fe/z_provider/dich.vu.provider.dart';
import 'package:fe/z_provider/hoa.don.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HoaDonNTScreen extends StatefulWidget {
  const HoaDonNTScreen({super.key});

  @override
  State<HoaDonNTScreen> createState() => _HoaDonNTScreenState();
}

class _HoaDonNTScreenState extends State<HoaDonNTScreen> {
  final ScrollController _scrollController = ScrollController();
  List<HoaDonModel> listHoaDon = [];
  getData() async {
    var response = await HoaDonProvider.getList();
    setState(() {
      listHoaDon = response;
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
        actions: [
          InkWell(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: "0349398690",
              );
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
        padding: const EdgeInsets.all(20),
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
                            builder: (BuildContext context) => XemHoaDon(
                              hoaDonModel: listHoaDon[index],
                              // callBack: (value) {
                              //   if (value != null) {
                              //     setState(() {
                              //       listHoaDon[index] = value;
                              //     });
                              //   }
                              // },
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
                                  style: TextStyle(fontSize: 22),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Trạng thái: ${valueStatusHoaDon(listHoaDon[index].status ?? -1)}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(color: (listHoaDon[index].status == 1) ? Colors.green : Colors.red),
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
