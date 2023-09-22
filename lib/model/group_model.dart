import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/model/user_model.dart';

class GroupModel extends Equatable {
  String? id;
  num groupType;
  List<UserModel> members;
  UserModel? ownerUin;
  String? createdAt;
  String? updatedAt;
  MessageModel? lastMessage;

  GroupModel({
    this.id,
    required this.groupType,
    required this.members,
    this.ownerUin,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [id, groupType, members, ownerUin, createdAt, updatedAt, lastMessage];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (id != null) {
      result.addAll({'_id': id});
    }
    result.addAll({'groupType': groupType});
    result.addAll({'members': members.map((x) => x.toMap()).toList()});
    if (ownerUin != null) {
      result.addAll({'ownerUin': ownerUin!.toMap()});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (lastMessage != null) {
      result.addAll({'lastMessage': lastMessage!.toMap()});
    }
    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['_id'],
      groupType: map['groupType'] ?? 0,
      members: List<UserModel>.from(map['members']?.map((x) => UserModel.fromMap(x))),
      ownerUin: map['ownerUin'] != null ? UserModel.fromMap(map['ownerUin']) : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      lastMessage: map['lastMessage'] != null ? MessageModel.fromMap(map['lastMessage']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));
}
