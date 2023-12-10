// ignore_for_file: prefer_const_constructors

import 'package:fe/z_provider/hoa.don.provider.dart';
import 'package:fe/z_provider/hop.dong.provider.dart';
import 'package:fe/z_provider/nguoi.dung.provider.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeChuTroScreen extends StatefulWidget {
  const HomeChuTroScreen({super.key});

  @override
  State<HomeChuTroScreen> createState() => _HomeChuTroScreenState();
}

class _HomeChuTroScreenState extends State<HomeChuTroScreen> {
  String timeNow = "";

  //
  int hoaDonCount = 0;
  int hoaDonDaDong = 0;
  //
  int hopDongCount = 0;

  //
  int phongCount = 0;
  int phongDatThue = 0;
  //
  int nguoiThueCount = 0;

  setData() async {
    getCountHoaDon();
    getHopDong();
    getPhongTro();
    getNguoiThue();
    setState(() {
      timeNow = DateFormat('MM-yyyy').format(DateTime.now());
    });
  }

  getCountHoaDon() async {
    var listHD = await HoaDonProvider.getList(dateSearch: "${DateFormat('yyyy-MM').format(DateTime.now())}-01");
    var listHDDaDong = await HoaDonProvider.getList(status: 2, dateSearch: "${DateFormat('yyyy-MM').format(DateTime.now())}-01");
    setState(() {
      hoaDonCount = listHD.length;
      hoaDonDaDong = listHDDaDong.length;
    });
  }

  getHopDong() async {
    var listHopDong = await HopDongProvider.getList(selectedStatus: 1, numberPage: 0);
    setState(() {
      hopDongCount = listHopDong.length;
    });
  }

  getPhongTro() async {
    var listPhongTro = await PhongProvider.getList();
    var listPhongTroCT = await PhongProvider.getListDaThue();
    setState(() {
      phongCount = listPhongTro.length;
      phongDatThue = listPhongTroCT.length;
    });
  }

  getNguoiThue() async {
    var listNguoiThue = await NguoiDungProvider.getListDangThue();
    setState(() {
      nguoiThueCount = listNguoiThue.length;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Row(),
        title: const Center(
            child: Text(
          "Happy Home",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(2.0, 4.0), blurRadius: 8),
                    ]),
                    child: Column(
                      children: [
                        const Icon(Icons.paid, color: Colors.blue, size: 70),
                        Text(
                          "Hoá đơn :$timeNow",
                          style: const TextStyle(fontSize: 17),
                        ),
                        Text("$hoaDonDaDong / $hoaDonCount", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(2.0, 4.0), blurRadius: 8),
                    ]),
                    child: Column(
                      children: [
                        const Icon(Icons.article, color: Color.fromARGB(255, 249, 110, 55), size: 70),
                        const Text(
                          "Hợp đồng",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text("$hopDongCount", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(2.0, 4.0), blurRadius: 8),
                    ]),
                    child: Column(
                      children: [
                        const Icon(Icons.room_service, color: Color.fromARGB(255, 33, 243, 166), size: 70),
                        Text(
                          "Phòng trọ thuê",
                          style: const TextStyle(fontSize: 17),
                        ),
                        Text("$phongDatThue / $phongCount", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(2.0, 4.0), blurRadius: 8),
                    ]),
                    child: Column(
                      children: [
                        const Icon(Icons.group, color: Color.fromARGB(255, 178, 55, 249), size: 70),
                        const Text(
                          "Người thuê",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text("$nguoiThueCount", style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
