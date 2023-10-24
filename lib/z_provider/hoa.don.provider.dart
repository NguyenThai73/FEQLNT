import 'dart:convert';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'base.url.dart';

class HoaDonProvider {
  HoaDonProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list id Hợp đồng đã có hoá đơn theo tháng >>>>
  static Future<List<HoaDonModel>> getList() async {
    "";
    List<HoaDonModel> listData = [];
    try {
      var url = "$baseUrl/api/hoa-don/get/page";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HoaDonModel item = HoaDonModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  // <<<< Get list id Hợp đồng đã có hoá đơn theo tháng >>>>
  static Future<List<int>> getListHoaDonThang({required String thang}) async {
    "";
    List<int> listData = [];
    try {
      String monthFilter = DateFormat('MM-yyyy').format(DateTime.parse(thang));
      var url = "$baseUrl/api/hoa-don/get/page?filter=status:1 and name>:'01-$monthFilter 00:00:00' and name<:'01-$monthFilter 23:59:59'&size=100000";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HoaDonModel item = HoaDonModel.fromMap(element);
            listData.add(item.idHopDong!);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  //Theem moi
  static Future<bool> themMoi(HoaDonModel hoaDonModel) async {
    try {
      var url = "$baseUrl/api/hoa-don/post";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: hoaDonModel.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        return bodyConvert;
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }
}
