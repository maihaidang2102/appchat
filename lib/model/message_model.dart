// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MessageModel extends Equatable {
  String? id;
  num? type;
  bool? status;
  String? groupId;
  String? message;
  String? senderInfo;
  List<String>? seenUin;
  MessageModel({
    this.id,
    this.type,
    this.status,
    this.groupId,
    this.message,
    this.senderInfo,
    this.seenUin,
  });

  @override
  List<Object?> get props => [type, status, groupId, message, senderInfo];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (groupId != null) {
      result.addAll({'groupId': groupId});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (senderInfo != null) {
      result.addAll({'senderInfo': senderInfo});
    }
    if (seenUin != null) {
      result.addAll({'seenUin': seenUin});
    }

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      type: map['type'],
      status: map['status'],
      groupId: map['groupId'],
      message: map['message'],
      senderInfo: map['senderInfo'],
      seenUin: List<String>.from(map['seenUin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
