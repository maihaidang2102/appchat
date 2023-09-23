import 'dart:convert';


class GroupResponse {
  bool? status;
  String? message;
  GroupData? data;
  GroupResponse({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (status != null) {
      result.addAll({'status': status});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (data != null) {
      result.addAll({'data': data!.toMap()});
    }

    return result;
  }

  factory GroupResponse.fromMap(Map<String, dynamic> map) {
    return GroupResponse(
      status: map['status'],
      message: map['message'],
      data: map['data'] != null ? GroupData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupResponse.fromJson(String source) =>
      GroupResponse.fromMap(json.decode(source));
}

class GroupData {
  String? id;
  int? groupType;
  List<String>? members;
  String? ownerUin;
  GroupData({
    this.id,
    this.groupType,
    this.members,
    this.ownerUin,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'_id': id});
    }
    if (groupType != null) {
      result.addAll({'groupType': groupType});
    }
    if (members != null) {
      result.addAll({'members': members});
    }
    if (ownerUin != null) {
      result.addAll({'ownerUin': ownerUin});
    }

    return result;
  }

  factory GroupData.fromMap(Map<String, dynamic> map) {
    return GroupData(
      id: map['_id'],
      groupType: map['groupType']?.toInt(),
      members: List<String>.from(map['members']),
      ownerUin: map['ownerUin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupData.fromJson(String source) =>
      GroupData.fromMap(json.decode(source));
}
