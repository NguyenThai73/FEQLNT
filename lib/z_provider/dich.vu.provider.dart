import 'dart:convert';
import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:http/http.dart' as http;
import 'base.url.dart';

class DichVuProvider {
  DichVuProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<DichVuModel>> getList() async {
    List<DichVuModel> listData = [];
    try {
      var url = "$baseUrl/api/dich-vu/get/page";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            DichVuModel item = DichVuModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static themMoi(DichVuModel item) async {
    try {
      var url = "$baseUrl/api/dich-vu/post";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert == true) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {}
    return false;
  }

  static sua(DichVuModel item) async {
    try {
      var url = "$baseUrl/api/dich-vu/put/${item.id}";
      var header = await getHeader();
      await http.put(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }

  static Future<DichVuModel> getById(String key) async {
    List<DichVuModel> listData = [];
    try {
      var url = "$baseUrl/api/dich-vu/get/page?filter=id:$key";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            DichVuModel item = DichVuModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData.first;
  }
}
