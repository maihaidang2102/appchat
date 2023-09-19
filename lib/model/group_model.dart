// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:chat/model/message_model.dart';
import 'package:chat/model/user_model.dart';

class GroupModel extends Equatable {
  String? name;
  num groupType;
  String? lastActiveTime;
  MessageModel? lastMessage;
  List<UserModel> members;
  UserModel? ownerUin;
  GroupModel({
    required this.name,
    required this.groupType,
    required this.lastActiveTime,
    required this.lastMessage,
    required this.members,
    required this.ownerUin,
  });
  @override
  List<Object?> get props =>
      [name, groupType, lastActiveTime, lastMessage, members, ownerUin];


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    result.addAll({'groupType': groupType});
    if(lastActiveTime != null){
      result.addAll({'lastActiveTime': lastActiveTime});
    }
    if(lastMessage != null){
      result.addAll({'lastMessage': lastMessage!.toMap()});
    }
    result.addAll({'members': members.map((x) => x.toMap()).toList()});
    if(ownerUin != null){
      result.addAll({'ownerUin': ownerUin!.toMap()});
    }
  
    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      name: map['name'],
      groupType: map['groupType'] ?? 0,
      lastActiveTime: map['lastActiveTime'],
      lastMessage: map['lastMessage'] != null ? MessageModel.fromMap(map['lastMessage']) : null,
      members: List<UserModel>.from(map['members']?.map((x) => UserModel.fromMap(x))),
      ownerUin: map['ownerUin'] != null ? UserModel.fromMap(map['ownerUin']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));
}
