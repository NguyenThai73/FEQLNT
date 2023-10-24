import 'dart:convert';
import 'package:fe/models/phong/phong.model.dart';
import 'package:http/http.dart' as http;
import 'base.url.dart';

class PhongProvider {
  PhongProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<PhongModel>> getList() async {
    List<PhongModel> listData = [];
    try {
      var url = "$baseUrl/api/phong/get/page";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            PhongModel item = PhongModel.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  // <<<< Get list >>>>
  static Future<List<PhongModel>> getListFilter() async {
    List<PhongModel> listData = [];
    try {
      var url = "$baseUrl/api/phong/get/page";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            PhongModel item = PhongModel.fromMap(element);
            listData.add(item);
          }
        }
      }
      listData.insert(0, PhongModel(name: "Tất cả"));
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static Future<int> themMoi(PhongModel item) async {
    try {
      var url = "$baseUrl/api/phong/post";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        print("bodyConvert: $bodyConvert");
        return int.tryParse(bodyConvert.toString()) ?? 0;
      }
    } catch (e) {
      print("Loi $e");
    }
    return 0;
  }

  static sua(PhongModel item) async {
    try {
      var url = "$baseUrl/api/phong/put/${item.id}";
      var header = await getHeader();
      await http.put(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }

  // <<<< Get list >>>>
  static Future<List<PhongModel>> getListChuaThue() async {
    List<PhongModel> listData = [];
    try {
      var url = "$baseUrl/api/phong/get/page?filter=status:1";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            PhongModel item = PhongModel.fromMap(element);
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
