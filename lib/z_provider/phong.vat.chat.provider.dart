import 'dart:convert';
import 'package:fe/models/phong/phong.vat.chat.dart';
import 'package:http/http.dart' as http;
import 'base.url.dart';

class PhongVatChatProvider {
  PhongVatChatProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<PhongVatChat>> getList(int idPhong) async {
    List<PhongVatChat> listData = [];
    try {
      var url = "$baseUrl/api/phong-vat-chat/get/page?filter=idPhong:$idPhong";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            PhongVatChat item = PhongVatChat.fromMap(element);
            listData.add(item);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static themMoi(PhongVatChat item) async {
    try {
      var url = "$baseUrl/api/phong-vat-chat/post";
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

  static sua(PhongVatChat item) async {
    try {
      var url = "$baseUrl/api/phong-vat-chat/put/${item.id}";
      var header = await getHeader();
      await http.put(Uri.parse(url.toString()), body: item.toJson(), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }

  static xoa(PhongVatChat item) async {
    try {
      var url = "$baseUrl/api/phong-vat-chat/del/${item.id}";
      var header = await getHeader();
      await http.delete(Uri.parse(url.toString()), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }
}
