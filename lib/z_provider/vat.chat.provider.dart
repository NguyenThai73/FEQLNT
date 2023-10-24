import 'dart:convert';
import 'package:fe/models/vat_chat/vat.chat.model.dart';
import 'package:http/http.dart' as http;
import 'base.url.dart';

class VatChatProvider {
  VatChatProvider._();
  static Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
    };

    return header;
  }

  // <<<< Get list >>>>
  static Future<List<VatChat>> getList() async {
    List<VatChat> listData = [];
    try {
      var url = "$baseUrl/api/vat-chat/get/page";
      var response = await http.get(Uri.parse(url.toString()));
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          for (var element in bodyConvert['result']['content']) {
            VatChat nha = VatChat.fromMap(element);
            print(element);
            listData.add(nha);
          }
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return listData;
  }

  static themMoi(VatChat nhaModel) async {
    try {
      var url = "$baseUrl/api/vat-chat/post";
      var header = await getHeader();
      var response = await http.post(Uri.parse(url.toString()), body: nhaModel.toJson(), headers: header);
      if (response.statusCode == 200) {
        var bodyConvert = jsonDecode(response.body);
        if (bodyConvert['success'] == true) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print("Loi $e");
    }
    return false;
  }

  static sua(VatChat nhaModel) async {
    try {
      var url = "$baseUrl/api/vat-chat/put/${nhaModel.id}";
      var header = await getHeader();
      await http.put(Uri.parse(url.toString()), body: nhaModel.toJson(), headers: header);
      return true;
    } catch (e) {
      print("Loi $e");
      return false;
    }
  }
}
