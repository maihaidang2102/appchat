import 'dart:convert';

class UserModel {
  String? userName;
  String userIP;
  num role;
  UserModel({
    this.userName,
    required this.userIP,
    required this.role,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(userName != null){
      result.addAll({'userName': userName});
    }
    result.addAll({'userIP': userIP});
    result.addAll({'role': role});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      userIP: map['userIP'] ?? '',
      role: map['role'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
