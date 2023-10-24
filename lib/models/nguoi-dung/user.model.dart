// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fe/models/hop_dong/hop.dong.model.dart';

class NguoiDungModel {
  int? id;
  int? idHopDong;
  HopDongModel? hopDong;
  String? username;
  String? password;
  int? role;
  String? fullName;
  String? namSinh;
  String? sdt;
  String? avatar;
  String? fileCccd;
  int? status;
  NguoiDungModel({
    this.id,
    this.idHopDong,
    this.hopDong,
    this.username,
    this.password,
    this.role,
    this.fullName,
    this.namSinh,
    this.sdt,
    this.avatar,
    this.fileCccd,
    this.status,
  });

  NguoiDungModel copyWith({
    int? id,
    int? idHopDong,
    HopDongModel? hopDong,
    String? username,
    String? password,
    int? role,
    String? fullName,
    String? namSinh,
    String? sdt,
    String? avatar,
    String? fileCccd,
    int? status,
  }) {
    return NguoiDungModel(
      id: id ?? this.id,
      idHopDong: idHopDong ?? this.idHopDong,
      hopDong: hopDong ?? this.hopDong,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      namSinh: namSinh ?? this.namSinh,
      sdt: sdt ?? this.sdt,
      avatar: avatar ?? this.avatar,
      fileCccd: fileCccd ?? this.fileCccd,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idHopDong': idHopDong,
      'username': username,
      'password': password,
      'role': role,
      'fullName': fullName,
      'namSinh': namSinh,
      'sdt': sdt,
      'avatar': avatar,
      'fileCccd': fileCccd,
      'status': status,
    };
  }

  factory NguoiDungModel.fromMap(Map<String, dynamic> map) {
    return NguoiDungModel(
      id: map['id'] != null ? map['id'] as int : null,
      idHopDong: map['idHopDong'] != null ? map['idHopDong'] as int : null,
      hopDong: map['hopDong'] != null ? HopDongModel.fromMap(map['hopDong'] as Map<String,dynamic>) : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      namSinh: map['namSinh'] != null ? map['namSinh'] as String : null,
      sdt: map['sdt'] != null ? map['sdt'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      fileCccd: map['fileCccd'] != null ? map['fileCccd'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NguoiDungModel.fromJson(String source) => NguoiDungModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NguoiDungModel(id: $id, idHopDong: $idHopDong, hopDong: $hopDong, username: $username, password: $password, role: $role, fullName: $fullName, namSinh: $namSinh, sdt: $sdt, avatar: $avatar, fileCccd: $fileCccd, status: $status)';
  }

  @override
  bool operator ==(covariant NguoiDungModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.idHopDong == idHopDong &&
      other.hopDong == hopDong &&
      other.username == username &&
      other.password == password &&
      other.role == role &&
      other.fullName == fullName &&
      other.namSinh == namSinh &&
      other.sdt == sdt &&
      other.avatar == avatar &&
      other.fileCccd == fileCccd &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idHopDong.hashCode ^
      hopDong.hashCode ^
      username.hashCode ^
      password.hashCode ^
      role.hashCode ^
      fullName.hashCode ^
      namSinh.hashCode ^
      sdt.hashCode ^
      avatar.hashCode ^
      fileCccd.hashCode ^
      status.hashCode;
  }
}
