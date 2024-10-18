// ignore_for_file: dangling_library_doc_comments

import 'package:equatable/equatable.dart';

class MUser extends Equatable {
  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _token;
  String? _idStatus;
  String? _createdAt;
  String? _updatedAt;
  String? _playerId;
  String? _image;

  String get id => _id ?? '';
  String get email => _email ?? '';
  String get name => _name ?? '';
  String get password => _password ?? '';
  String get token => _token ?? '';
  String get idStatus => _idStatus ?? 'PENDING';
  String get createdAt => _createdAt ?? '';
  String get updatedAt => _updatedAt ?? '';
  String get playerId => _playerId ?? '';
  String get image => _image ?? 'avatar00.jpg';

  void settoken(String token) {
    _token = token;
  }

  MUser.fromJSON(Map<String, dynamic> json) {
    _id = json['_id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _token = json['token'];
    _idStatus = json['id_status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _playerId = json['playerId'];
    _image = json['image'];
  }

  @override
  List<Object?> get props => [
        _id,
        _email,
        _name,
        _password,
        _token,
        _idStatus,
        _createdAt,
        _updatedAt,
        _playerId,
        _image,
      ];
}

extension MUserExt on MUser {
  bool get isPending => idStatus == 'PENDING';
  bool get isActive => idStatus == 'ACTIVE';
  bool get isBlocked => idStatus == 'BLOCKED';
  bool get isDeleted => idStatus == 'DELETED';
}
