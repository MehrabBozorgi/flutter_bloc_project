import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }

  factory UserModel.initial() => const UserModel(
        id: 0,
        name: '',
        email: '',
        gender: '',
        status: '',
      );

  @override
  List<Object> get props => [id, name, email, gender, status];

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      status: status ?? this.status,
    );
  }
}
