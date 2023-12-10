import 'dart:convert';
import 'package:fe/models/hop_dong/hop.dong.model.dart';
import 'package:fe/z_provider/phong.provider.dart';
import 'package:http/http.dart' as http;
import 'base.url.dart';

class HopDongProvider {
  HopDongProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<HopDongModel>> getList({required int selectedStatus, required int numberPage, int? selectPhong}) async {
    List<HopDongModel> listData = [];
    try {
      var filter = "";
      var filterStatus = "";
      var filterPhong = "";

      if (selectedStatus != -1) {
        filterStatus = "status:$selectedStatus";
      }
      if (selectPhong != null) {
        filterPhong = "idPhong:$selectPhong";
      }
      if (filterStatus != "" && filterPhong != "") {
        filter = "filter=$filterPhong and $filterStatus";
      } else {
        if (filterStatus != "") {
          filter = "filter=$filterStatus";
        }
        if (filterPhong != "") {
          filter = "filter=$filterPhong";
        }
      }

      var url = "$baseUrl/api/hop-dong/get/page?${filter != "" ? filter : ""}&page=$numberPage";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HopDongModel item = HopDongModel.fromMap(element);
            var dateEnd = DateTime.parse(item.dateEnd!);
            DateTime currentDate = DateTime.now();
            if (dateEnd.isBefore(currentDate) && item.status == 1) {
              //Hop dong het han
              item.status == 0;
              await sua(item);
              //Chuyen Phong ve trang thai dang trong
              item.phong?.status = 1;
              await PhongProvider.sua(item.phong!);
            }
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<bool> themMoi(HopDongModel item) async {
    print("object");
    try {
      var url = "$baseUrl/api/hop-dong/post";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        return bodyConvert;
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }

  static Future<bool> sua(HopDongModel item) async {
    try {
      var url = "$baseUrl/api/hop-dong/put/${item.id}";
      var header = await getHeader();
      await http.put(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }

  // <<<< Get list làm hoá đơn >>>>
  static Future<List<HopDongModel>> getListToHoaDon({required List<int> list}) async {
    List<HopDongModel> listData = [];
    try {
      String filter = "filter=";
      if (list.isNotEmpty) {
        for (var i = 0; i < list.length; i++) {
          filter += "id!${list[i]} and ";
        }
      }
      filter = filter.substring(0, filter.length - 5);
      var url = "";

      if (list.isNotEmpty) {
        url = "$baseUrl/api/hop-dong/get/page?$filter and status:1&size:100000";
      } else {
        url = "$baseUrl/api/hop-dong/get/page?filter=status:1&size:100000";
      }
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HopDongModel item = HopDongModel.fromMap(element);
            var dateEnd = DateTime.parse(item.dateEnd!);
            DateTime currentDate = DateTime.now();
            if (dateEnd.isBefore(currentDate) && item.status == 1) {
              //Hop dong het han
              item.status == 0;
              await sua(item);
              //Chuyen Phong ve trang thai dang trong
              item.phong?.status = 1;
              await PhongProvider.sua(item.phong!);
            }
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  // <<<< Get list để tạo mới người dùng >>>>
  static Future<List<HopDongModel>> getListForNguoiDung() async {
    List<HopDongModel> listData = [];
    try {
      var url = "$baseUrl/api/hop-dong/get/page?filter=status:1&size:100000";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HopDongModel item = HopDongModel.fromMap(element);
            var dateEnd = DateTime.parse(item.dateEnd!);
            DateTime currentDate = DateTime.now();
            if (dateEnd.isBefore(currentDate) && item.status == 1) {
              //Hop dong het han
              item.status == 0;
              await sua(item);
              //Chuyen Phong ve trang thai dang trong
              item.phong?.status = 1;
              await PhongProvider.sua(item.phong!);
            }
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }


    // <<<< Get alll >>>>
  static Future<List<HopDongModel>> getListAll() async {
    List<HopDongModel> listData = [];
    try {
      

      var url = "$baseUrl/api/hop-dong/get/page?size=10000&sort=status,desc";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            HopDongModel item = HopDongModel.fromMap(element);
            var dateEnd = DateTime.parse(item.dateEnd!);
            DateTime currentDate = DateTime.now();
            if (dateEnd.isBefore(currentDate) && item.status == 1) {
              //Hop dong het han
              item.status == 0;
              await sua(item);
              //Chuyen Phong ve trang thai dang trong
              item.phong?.status = 1;
              await PhongProvider.sua(item.phong!);
            }
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
