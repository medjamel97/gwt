import '../utils/base_model.dart';
import '../utils/from_map.dart';

class User extends BaseModel {
  String? email;
  String? name;

  User({
    required super.id,
    required this.email,
    required this.name,
  });

  @override
  String? get mainAttribute => email;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: FromMap.string(map['id']),
      email: FromMap.string(map['email']),
      name: FromMap.string(map['name']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }
}
