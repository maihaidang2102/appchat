class GroupResponse {
  bool status;
  String message;
  GroupData data;

  GroupResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    return GroupResponse(
      status: json['status'],
      message: json['message'],
      data: GroupData.fromJson(json['data']),
    );
  }
}

class GroupData {
  String id;
  int groupType;
  List<String> members;
  String ownerUin;

  GroupData({
    required this.id,
    required this.groupType,
    required this.members,
    required this.ownerUin,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['_id'],
      groupType: json['groupType'],
      members: List<String>.from(json['members']),
      ownerUin: json['ownerUin'],
    );
  }
}
