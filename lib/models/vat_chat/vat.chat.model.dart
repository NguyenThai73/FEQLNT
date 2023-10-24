// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VatChat {
  int? id;
  String? name;
  VatChat({
    this.id,
    this.name,
  });

  VatChat copyWith({
    int? id,
    String? name,
  }) {
    return VatChat(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory VatChat.fromMap(Map<String, dynamic> map) {
    return VatChat(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VatChat.fromJson(String source) => VatChat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VatChat(id: $id, name: $name)';

  @override
  bool operator ==(covariant VatChat other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
