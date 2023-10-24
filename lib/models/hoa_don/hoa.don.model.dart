// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/models/dich_vu/dich.vu.model.dart';
import 'package:fe/models/hop_dong/hop.dong.model.dart';

class HoaDonModel {
  int? id;
  int? idHopDong;
  HopDongModel? hopDong;
  String? name;
  String? data;
  String? file;
  String? fileCk;
  String? dueDate;
  int? fine;
  int? total;
  String? description;
  int? status;
  List<DichVuModel>? listDichVu = [];
  List<int>? listSoLuong = [];
  List<int>? listTotalDichVu = [];
  HoaDonModel({
    this.id,
    this.idHopDong,
    this.hopDong,
    this.name,
    this.data,
    this.file,
    this.fileCk,
    this.dueDate,
    this.fine,
    this.total,
    this.description,
    this.status,
    this.listDichVu,
    this.listSoLuong,
    this.listTotalDichVu,
  });

  HoaDonModel copyWith({
    int? id,
    int? idHopDong,
    HopDongModel? hopDong,
    String? name,
    String? data,
    String? file,
    String? fileCk,
    String? dueDate,
    int? fine,
    int? total,
    String? description,
    int? status,
  }) {
    return HoaDonModel(
      id: id ?? this.id,
      idHopDong: idHopDong ?? this.idHopDong,
      hopDong: hopDong ?? this.hopDong,
      name: name ?? this.name,
      data: data ?? this.data,
      file: file ?? this.file,
      fileCk: fileCk ?? this.fileCk,
      dueDate: dueDate ?? this.dueDate,
      fine: fine ?? this.fine,
      total: total ?? this.total,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, int> detailDataConver = {};
    if (listDichVu!.isNotEmpty) {
      for (int i = 0; i < listDichVu!.length; i++) {
        detailDataConver.addAll({listDichVu![i].id.toString(): listSoLuong![i]});
      }
    }
    return <String, dynamic>{
      'id': id,
      'idHopDong': idHopDong,
      'name': name,
      'data':jsonEncode(detailDataConver),
      'file': file,
      'fileCk': fileCk,
      'dueDate': dueDate,
      'fine': fine,
      'total': total,
      'description': description,
      'status': status,
    };
  }

  factory HoaDonModel.fromMap(Map<String, dynamic> map) {
    var hoaDonModel = HoaDonModel(
      id: map['id'] != null ? map['id'] as int : null,
      idHopDong: map['idHopDong'] != null ? map['idHopDong'] as int : null,
      hopDong: map['hopDong'] != null ? HopDongModel.fromMap(map['hopDong'] as Map<String, dynamic>) : null,
      name: map['name'] != null ? map['name'] as String : null,
      data: map['data'] != null ? map['data'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      fileCk: map['fileCk'] != null ? map['fileCk'] as String : null,
      dueDate: map['dueDate'] != null ? map['dueDate'] as String : null,
      fine: map['fine'] != null ? map['fine'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      description: map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
    // if (hoaDonModel.data != null) {
    //   var dataConvert = jsonDecode(hoaDonModel.data!) as Map<int, int>;
    //   dataConvert.entries.forEach((element) {

    //     hoaDonModel.detailData.addAll({});
    //   });
    // }
    return hoaDonModel;
  }

  String toJson() => json.encode(toMap());

  factory HoaDonModel.fromJson(String source) => HoaDonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HoaDonModel(id: $id, idHopDong: $idHopDong, hopDong: $hopDong, name: $name, data: $data, file: $file, dueDate: $dueDate, fine: $fine, total: $total, description: $description, status: $status)';
  }

  @override
  bool operator ==(covariant HoaDonModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.idHopDong == idHopDong && other.hopDong == hopDong && other.name == name && other.data == data && other.file == file && other.dueDate == dueDate && other.fine == fine && other.total == total && other.description == description && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idHopDong.hashCode ^ hopDong.hashCode ^ name.hashCode ^ data.hashCode ^ file.hashCode ^ dueDate.hashCode ^ fine.hashCode ^ total.hashCode ^ description.hashCode ^ status.hashCode;
  }
}
