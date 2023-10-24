import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/hop.dong/ui/hop.dong.screen.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hop_dong/nguoi.thue/ui/nguoi.dung.screen.dart';
import 'package:flutter/material.dart';

class QuanLyHopDongScreen extends StatefulWidget {
  const QuanLyHopDongScreen({super.key});

  @override
  State<QuanLyHopDongScreen> createState() => _QuanLyHopDongScreenState();
}

class _QuanLyHopDongScreenState extends State<QuanLyHopDongScreen> {
  bool showFilter = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
           leading: Row(),
          backgroundColor: Colors.blue,
          title: const Center(
              child: Text(
            "Quản lý hợp đồng",
            style: TextStyle(color: Colors.white),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    showFilter = !showFilter;
                  });
                },
                icon: Icon(
                  !showFilter ? Icons.filter_alt : Icons.filter_alt_off,
                  color: Colors.white,
                ))
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 196, 196, 196),
            labelStyle: TextStyle(fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.article),
                    Text(" Hợp đồng"),
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.group),
                    Text(" Người thuê"),
                  ],
                ),
              ),
            ],
            indicatorWeight: 1,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HopDongScreen(showFilter: showFilter),
            NguoiDungScreen(showFilter: showFilter),
          ],
        ),
      ),
    );
  }
}
