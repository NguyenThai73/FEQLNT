import 'dart:convert';
import 'package:fe/models/hoa_don/hoa.don.model.dart';
import 'package:fe/models/nguoi-dung/user.model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'base.url.dart';

class NguoiDungProvider {
  NguoiDungProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list id Hợp đồng đã có hoá đơn theo tháng >>>>
  static Future<List<NguoiDungModel>> getList({required int selectedStatus, required int numberPage, int? selectHopDong}) async {
    "";
    List<NguoiDungModel> listData = [];
    try {
      var filter = "";
      var filterStatus = "";
      var filterPhong = "";

      if (selectedStatus != -1) {
        filterStatus = "status:$selectedStatus";
      }
      if (selectHopDong != null) {
        filterPhong = "idHopDong:$selectHopDong";
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

      var url = "$baseUrl/api/nguoi-dung/get/page?${filter != "" ? "$filter and role:1" : "filter=role:1"}&page=$numberPage";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            NguoiDungModel item = NguoiDungModel.fromMap(element);
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
  static Future<bool> themMoi(NguoiDungModel nguoiDungModel) async {
    try {
      var url = "$baseUrl/api/nguoi-dung/create";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: nguoiDungModel.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        return bodyConvert['success'];
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }

  //Sua
  static Future<bool> sua(NguoiDungModel nguoiDungModel) async {
    try {
      var url = "$baseUrl/api/nguoi-dung/put/${nguoiDungModel.id}";
      var header = await getHeader();
      var response = await http.put(Uri.parse(url.toString()), body: nguoiDungModel.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        return bodyConvert['success'];
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }

  // <<<< Login >>>>
  static Future<NguoiDungModel?> login({required String email, required String password}) async {
    NguoiDungModel? nguoiDungModel;
    try {
      var url = "$baseUrl/api/nguoi-dung/login";
      Map<String, String> header = await getHeader();
      var responseBody = {'username': email, 'password': password};
      var body = json.encode(responseBody);
      var response = await http.post(Uri.parse(url.toString()), headers: header, body: body);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          return nguoiDungModel = NguoiDungModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {}
    return nguoiDungModel;
  }

  static Future<NguoiDungModel> getUserById({required String id}) async {
    "";
    NguoiDungModel nguoiDungModel = NguoiDungModel();
    try {
      var url = "$baseUrl/api/nguoi-dung/get/$id";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          nguoiDungModel = NguoiDungModel.fromMap(bodyConvert['result']);
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return nguoiDungModel;
  }
}
