// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/models/phong/phong.model.dart';

class HopDongModel {
  int? id;
  int? idPhong;
  PhongModel? phong;
  String? dateStart;
  String? dateEnd;
  String? file;
  int? numberPeople;
  int? status;
  HopDongModel({
    this.id,
    this.idPhong,
    this.phong,
    this.dateStart,
    this.dateEnd,
    this.file,
    this.numberPeople,
    this.status,
  });

  HopDongModel copyWith({
    int? id,
    int? idPhong,
    PhongModel? phong,
    String? dateStart,
    String? dateEnd,
    String? file,
    int? numberPeople,
    int? status,
  }) {
    return HopDongModel(
      id: id ?? this.id,
      idPhong: idPhong ?? this.idPhong,
      phong: phong ?? this.phong,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      file: file ?? this.file,
      numberPeople: numberPeople ?? this.numberPeople,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idPhong': idPhong,
      'phong': phong?.toMap(),
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'file': file,
      'numberPeople': numberPeople,
      'status': status,
    };
  }

  factory HopDongModel.fromMap(Map<String, dynamic> map) {
    return HopDongModel(
      id: map['id'] != null ? map['id'] as int : null,
      idPhong: map['idPhong'] != null ? map['idPhong'] as int : null,
      phong: map['phong'] != null ? PhongModel.fromMap(map['phong'] as Map<String, dynamic>) : null,
      dateStart: map['dateStart'] != null ? map['dateStart'] as String : null,
      dateEnd: map['dateEnd'] != null ? map['dateEnd'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
      numberPeople: map['numberPeople'] != null ? map['numberPeople'] as int : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HopDongModel.fromJson(String source) => HopDongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HopDongModel(id: $id, idPhong: $idPhong, phong: $phong, dateStart: $dateStart, dateEnd: $dateEnd, file: $file, numberPeople: $numberPeople, status: $status)';
  }

  @override
  bool operator ==(covariant HopDongModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.idPhong == idPhong && other.phong == phong && other.dateStart == dateStart && other.dateEnd == dateEnd && other.file == file && other.numberPeople == numberPeople && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idPhong.hashCode ^ phong.hashCode ^ dateStart.hashCode ^ dateEnd.hashCode ^ file.hashCode ^ numberPeople.hashCode ^ status.hashCode;
  }
}
