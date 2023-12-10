import 'package:fe/app_theme.dart';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/views/component/custom_drawerNT/drawer_user_controller.dart';
import 'package:fe/views/component/custom_drawerNT/home_drawer.dart';
import 'package:fe/views/component/wilps/will.pop.scope.dart';
import 'package:fe/views/screens/app_nguoi_tro/hoa.don.user.screen.dart';
import 'package:fe/views/screens/app_nguoi_tro/xem.phhong.dart';
import 'package:fe/views/screens/profile/ui/profile.screen.dart';
import 'package:flutter/material.dart';

class NavigationNguoiThueHomeScreen extends StatefulWidget {
  const NavigationNguoiThueHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationNguoiThueHomeScreenState createState() => _NavigationNguoiThueHomeScreenState();
}

class _NavigationNguoiThueHomeScreenState extends State<NavigationNguoiThueHomeScreen> {
  Widget? screenView;
  DrawerIndexNT? drawerIndex;
  PhongModel phongModel = PhongModel();

  @override
  void initState() {
    drawerIndex = DrawerIndexNT.Home;
    screenView = HoaDonNTScreen();
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
            body: DrawerUserControllerNT(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndexNT drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: screenView,
              callBackPhongModel: (value) {
                setState(() {
                  phongModel = value;
                });
              },
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndexNT drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndexNT.Home:
          setState(() {
            screenView = const HoaDonNTScreen();
          });
          break;
        case DrawerIndexNT.LienHe:
          setState(() {
            screenView = XemPhongScreen(
              phongModel: phongModel,
            );
          });
          break;
        case DrawerIndexNT.Profile:
          setState(() {
            screenView = const ProfileScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
