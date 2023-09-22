import 'dart:convert';

class ResponseListMessage {
  String event;
  List<MessageItem> listMessage;

  ResponseListMessage({
    required this.event,
    required this.listMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'listMessage': listMessage.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseListMessage.fromMap(Map<String, dynamic> map) {
    return ResponseListMessage(
      event: map['event'] ?? '',
      listMessage: List<MessageItem>.from(map['listMessage']?.map((x) => MessageItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseListMessage.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return ResponseListMessage.fromMap(map);
  }
}

class MessageItem {
  String id;
  int type;
  bool status;
  GroupId groupId;
  String message;
  SenderInfo senderInfo;
  List<dynamic> seenUin;
  String createdAt;
  String updatedAt;
  String lastMessage;

  MessageItem({
    required this.id,
    required this.type,
    required this.status,
    required this.groupId,
    required this.message,
    required this.senderInfo,
    required this.seenUin,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'type': type,
      'status': status,
      'groupId': groupId.toMap(),
      'message': message,
      'senderInfo': senderInfo.toMap(),
      'seenUin': seenUin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastMessage': lastMessage,
    };
  }

  factory MessageItem.fromMap(Map<String, dynamic> map) {
    return MessageItem(
      id: map['_id'] ?? '',
      type: map['type'] ?? 0,
      status: map['status'] ?? false,
      groupId: GroupId.fromMap(map['groupId'] ?? {}),
      message: map['message'] ?? '',
      senderInfo: SenderInfo.fromMap(map['senderInfo'] ?? {}),
      seenUin: List<dynamic>.from(map['seenUin'] ?? []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  factory MessageItem.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return MessageItem.fromMap(map);
  }
}

class GroupId {
  String id;
  int groupType;
  List<String> members;
  String ownerUin;

  GroupId({
    required this.id,
    required this.groupType,
    required this.members,
    required this.ownerUin,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'groupType': groupType,
      'members': members,
      'ownerUin': ownerUin,
    };
  }

  factory GroupId.fromMap(Map<String, dynamic> map) {
    return GroupId(
      id: map['_id'] ?? '',
      groupType: map['groupType'] ?? 0,
      members: List<String>.from(map['members'] ?? []),
      ownerUin: map['ownerUin'] ?? '',
    );
  }

  factory GroupId.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return GroupId.fromMap(map);
  }
}

class SenderInfo {
  String id;
  String userName;
  String userIP;
  int role;
  String createdAt;
  String updatedAt;

  SenderInfo({
    required this.id,
    required this.userName,
    required this.userIP,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userName': userName,
      'userIP': userIP,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SenderInfo.fromMap(Map<String, dynamic> map) {
    return SenderInfo(
      id: map['_id'] ?? '',
      userName: map['userName'] ?? '',
      userIP: map['userIP'] ?? '',
      role: map['role'] ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  factory SenderInfo.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return SenderInfo.fromMap(map);
  }
}
