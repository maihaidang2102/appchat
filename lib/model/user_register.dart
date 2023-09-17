class UserResponse {
  bool? status;
  String? message;
  Data? data;

  UserResponse({this.status, this.message, this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  String? id;
  String? userName;
  int? role;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.userName, this.role, this.createdAt, this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
