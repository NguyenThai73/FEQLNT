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
  static Future<List<HoaDonModel>> getList({int? status, String? dateSearch}) async {
    String filter = "sort=status";
    try {
      if (status != null && status != -1 && dateSearch != null) {
        filter = "filter=status:$status and name >: '${DateFormat('dd-MM-yyyy').format(DateTime.parse(dateSearch))} 00:00:00' and name<: '${getEndOfMonth(dateSearch)} 23:59:59'&sort=status";
      } else if (status != null && status != -1) {
        filter = "filter=status:$status&sort=status";
      } else if (dateSearch != null) {
        filter = "filter=name >: '${DateFormat('dd-MM-yyyy').format(DateTime.parse(dateSearch))} 00:00:00' and name<: '${getEndOfMonth(dateSearch)} 23:59:59'&sort=status";
      }
    } catch (e) {
      print("filter: $e");
    }

    List<HoaDonModel> listData = [];
    try {
      var url = "$baseUrl/api/hoa-don/get/page?$filter";
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

  static Future<bool> sua(HoaDonModel hoaDonModel) async {
    try {
      var url = "$baseUrl/api/hoa-don/put/${hoaDonModel.id}";
      var header = await getHeader();
      var response = await http.put(Uri.parse(url.toString()), body: hoaDonModel.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        return bodyConvert;
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }

  // <<<< Get list hoa don theo hop dong >>>>
  static Future<List<HoaDonModel>> getListHoaDonTheoHopDong({required int idHopDong}) async {
    "";
    List<HoaDonModel> listData = [];
    try {
      var url = "$baseUrl/api/hoa-don/get/page?filter=idHopDong:$idHopDong &size=100000&sort=status";
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
}

String getEndOfMonth(String inputDate) {
  DateTime inputDateTime = DateTime.parse(inputDate);

  DateTime nextMonth = DateTime(inputDateTime.year, inputDateTime.month + 1, 1);

  DateTime endOfMonth = nextMonth.subtract(Duration(days: 1));

  // Định dạng ngày cuối cùng theo yêu cầu "dd-MM-yyyy"
  String formattedEndOfMonth = "${endOfMonth.day.toString().padLeft(2, '0')}-${endOfMonth.month.toString().padLeft(2, '0')}-${endOfMonth.year}";

  return formattedEndOfMonth;
}
