// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NhaModel {
  int? id;
  String? name;
  String? address;
  String? moTa;
  int? status;
  NhaModel({
    this.id,
    this.name,
    this.address,
    this.moTa,
    this.status,
  });
 

  NhaModel copyWith({
    int? id,
    String? name,
    String? address,
    String? moTa,
    int? status,
  }) {
    return NhaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      moTa: moTa ?? this.moTa,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'moTa': moTa,
      'status': status,
    };
  }

  factory NhaModel.fromMap(Map<String, dynamic> map) {
    return NhaModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      moTa: map['moTa'] != null ? map['moTa'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NhaModel.fromJson(String source) => NhaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NhaModel(id: $id, name: $name, address: $address, moTa: $moTa, status: $status)';
  }

  @override
  bool operator ==(covariant NhaModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.moTa == moTa &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      moTa.hashCode ^
      status.hashCode;
  }
}
