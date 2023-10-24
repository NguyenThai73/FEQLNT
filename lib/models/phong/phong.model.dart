// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/models/nha_model/nha.model.dart';

class PhongModel {
  int? id;
  int? idNha;
  NhaModel? nha;
  String? name;
  int? gia;
  int? status;
  PhongModel({
    this.id,
    this.idNha,
    this.nha,
    this.name,
    this.gia,
    this.status,
  });

  PhongModel copyWith({
    int? id,
    int? idNha,
    NhaModel? nha,
    String? name,
    int? gia,
    int? status,
  }) {
    return PhongModel(
      id: id ?? this.id,
      idNha: idNha ?? this.idNha,
      nha: nha ?? this.nha,
      name: name ?? this.name,
      gia: gia ?? this.gia,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idNha': idNha,
      'name': name,
      'gia': gia,
      'status': status,
    };
  }

  factory PhongModel.fromMap(Map<String, dynamic> map) {
    return PhongModel(
      id: map['id'] != null ? map['id'] as int : null,
      idNha: map['idNha'] != null ? map['idNha'] as int : null,
      nha: map['nha'] != null ? NhaModel.fromMap(map['nha'] as Map<String, dynamic>) : null,
      name: map['name'] != null ? map['name'] as String : null,
      gia: map['gia'] != null ? map['gia'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhongModel.fromJson(String source) => PhongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PhongModel(id: $id, idNha: $idNha, nha: $nha, name: $name, gia: $gia, status: $status)';
  }

  @override
  bool operator ==(covariant PhongModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.idNha == idNha && other.nha == nha && other.name == name && other.gia == gia && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idNha.hashCode ^ nha.hashCode ^ name.hashCode ^ gia.hashCode ^ status.hashCode;
  }
}
