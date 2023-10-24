import 'package:fe/app_theme.dart';
import 'package:fe/views/component/custom_drawer/drawer_user_controller.dart';
import 'package:fe/views/component/custom_drawer/home_drawer.dart';
import 'package:fe/views/component/wilps/will.pop.scope.dart';
import 'package:fe/views/screens/app_chu_tro/co_so_vat_chat/ui/vat.chat.screen.dart';
import 'package:fe/views/screens/app_chu_tro/dich_vu/ui/dich.vu.screen.dart';
import 'package:fe/views/screens/app_chu_tro/home/home.screen.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_hoa_don/ui/hoa.don.screen.dart';
import 'package:fe/views/screens/app_chu_tro/quan_ly_nha/ui/nha.screen.dart';
import 'package:flutter/material.dart';

import 'profile/profile.screen.dart';
import 'quan_ly_hop_dong/quan.ly.hop.dong.screen.dart';
import 'quan_ly_phong/ui/phong.screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.Home;
    screenView = HomeChuTroScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPS(
      child: Container(
        color: AppTheme.white,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.Home:
          setState(() {
            screenView = const HomeChuTroScreen();
          });
          break;
        case DrawerIndex.HoaDon:
          setState(() {
            screenView = const HoaDonScreen();
          });
          break;
        case DrawerIndex.HopDong:
          setState(() {
            screenView = const QuanLyHopDongScreen();
          });
          break;
        case DrawerIndex.PhongTro:
          setState(() {
            screenView = const QuanLyPhongScreen();
          });
          break;
        case DrawerIndex.DichVu:
          setState(() {
            screenView = const DichVuScreen();
          });
          break;
        case DrawerIndex.CoSoVatChat:
          setState(() {
            screenView = const VatChatScreen();
          });
          break;
        case DrawerIndex.Nha:
          setState(() {
            screenView = const QuanLyNhaScreen();
          });
          break;
        case DrawerIndex.Chat:
          setState(() {
            screenView = const ProFileScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
