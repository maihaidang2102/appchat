// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MessageModel extends Equatable {
  num type;
  bool status;
  String groupId;
  String message;
  String senderInfo;
  MessageModel({
    required this.type,
    required this.status,
    required this.groupId,
    required this.message,
    required this.senderInfo,
  });
  
  @override
  List<Object?> get props =>[type, status, groupId, message, senderInfo];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'type': type});
    result.addAll({'status': status});
    result.addAll({'groupId': groupId});
    result.addAll({'message': message});
    result.addAll({'senderInfo': senderInfo});
  
    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      type: map['type'] ?? 0,
      status: map['status'] ?? false,
      groupId: map['groupId'] ?? '',
      message: map['message'] ?? '',
      senderInfo: map['senderInfo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}
