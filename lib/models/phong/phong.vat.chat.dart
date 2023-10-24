// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:fe/models/phong/phong.model.dart';
import 'package:fe/models/vat_chat/vat.chat.model.dart';

class PhongVatChat {
  int? id;
  int? idPhong;
  PhongModel? phong;
  int? idVatChat;
  VatChat? vatChat;
  int? status;
  PhongVatChat({
    this.id,
    this.idPhong,
    this.phong,
    this.idVatChat,
    this.vatChat,
    this.status,
  });

  PhongVatChat copyWith({
    int? id,
    int? idPhong,
    PhongModel? phong,
    int? idVatChat,
    VatChat? vatChat,
    int? status,
  }) {
    return PhongVatChat(
      id: id ?? this.id,
      idPhong: idPhong ?? this.idPhong,
      phong: phong ?? this.phong,
      idVatChat: idVatChat ?? this.idVatChat,
      vatChat: vatChat ?? this.vatChat,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idPhong': idPhong,
      'idVatChat': idVatChat,
      'status': status,
    };
  }

  factory PhongVatChat.fromMap(Map<String, dynamic> map) {
    return PhongVatChat(
      id: map['id'] != null ? map['id'] as int : null,
      idPhong: map['idPhong'] != null ? map['idPhong'] as int : null,
      phong: map['phong'] != null ? PhongModel.fromMap(map['phong'] as Map<String,dynamic>) : null,
      idVatChat: map['idVatChat'] != null ? map['idVatChat'] as int : null,
      vatChat: map['vatChat'] != null ? VatChat.fromMap(map['vatChat'] as Map<String,dynamic>) : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhongVatChat.fromJson(String source) => PhongVatChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PhongVatChat(id: $id, idPhong: $idPhong, phong: $phong, idVatChat: $idVatChat, vatChat: $vatChat, status: $status)';
  }

  @override
  bool operator ==(covariant PhongVatChat other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.idPhong == idPhong &&
      other.phong == phong &&
      other.idVatChat == idVatChat &&
      other.vatChat == vatChat &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idPhong.hashCode ^
      phong.hashCode ^
      idVatChat.hashCode ^
      vatChat.hashCode ^
      status.hashCode;
  }
}
