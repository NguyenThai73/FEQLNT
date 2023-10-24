// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/models/nha_model/nha.model.dart';

class DichVuModel {
  int? id;
  int? idNha;
  NhaModel? nha;
  String? name;
  // 0: theo người, 1: theo phòng, 3 theo số lượng
  int? donVi;
  int? donGia;
  DichVuModel({
    this.id,
    this.idNha,
    this.nha,
    this.name,
    this.donVi,
    this.donGia,
  });

  DichVuModel copyWith({
    int? id,
    int? idNha,
    NhaModel? nha,
    String? name,
    int? donVi,
    int? donGia,
  }) {
    return DichVuModel(
      id: id ?? this.id,
      idNha: idNha ?? this.idNha,
      nha: nha ?? this.nha,
      name: name ?? this.name,
      donVi: donVi ?? this.donVi,
      donGia: donGia ?? this.donGia,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idNha': idNha,
      'name': name,
      'donVi': donVi,
      'donGia': donGia,
    };
  }

  factory DichVuModel.fromMap(Map<String, dynamic> map) {
    return DichVuModel(
      id: map['id'] != null ? map['id'] as int : null,
      idNha: map['idNha'] != null ? map['idNha'] as int : null,
      nha: map['nha'] != null ? NhaModel.fromMap(map['nha'] as Map<String, dynamic>) : null,
      name: map['name'] != null ? map['name'] as String : null,
      donVi: map['donVi'] != null ? map['donVi'] as int : null,
      donGia: map['donGia'] != null ? map['donGia'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DichVuModel.fromJson(String source) => DichVuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DichVuModel(id: $id, idNha: $idNha, nha: $nha, name: $name, donVi: $donVi, donGia: $donGia)';
  }

  @override
  bool operator ==(covariant DichVuModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.idNha == idNha && other.nha == nha && other.name == name && other.donVi == donVi && other.donGia == donGia;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idNha.hashCode ^ nha.hashCode ^ name.hashCode ^ donVi.hashCode ^ donGia.hashCode;
  }
}

enum DonVi { nguoi, phong, soLuong }

String valueNameDonVi(int value) {
  switch (value) {
    case 0:
      return "VNĐ/người";
    case 1:
      return "VNĐ/phòng";
    case 2:
      return "VNĐ/số lượng";
    default:
      return "";
  }
}
