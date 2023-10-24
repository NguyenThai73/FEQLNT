// ignore_for_file: depend_on_referenced_packages, empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

String baseUrl = "http://192.168.12.101:8081";

Future<String?> handleUploadFile() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
  if (result != null) {
    try {
      for (var element in result.files) {
        String path = element.path ?? "";
        var fileNameUpload = await uploadFile(File(path));
        if (fileNameUpload != null) {
          if (fileName == null) {
            fileName = fileNameUpload;
          } else {
            fileName += ",$fileNameUpload";
          }
        }
      }
    } catch (e) {}
  } else {}

  return fileName;
}

Future<String?> handleUploadAvater() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null) {
    try {
      for (var element in result.files) {
        String path = element.path ?? "";
        var fileNameUpload = await uploadFile(File(path));
        fileName = fileNameUpload;
      }
    } catch (e) {}
  } else {}

  return fileName;
}

Future<String?> uploadFile(File file) async {
  try {
    Map<String, String> headers = {'content-type': 'application/json'};
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/upload"),
    );
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        'file', // Field name in the form-data
        http.ByteStream(file.openRead()),
        await file.length(),
        filename: 'file.jpg',
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var body = json.decode(responseBody);
      return body["1"];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
