import 'dart:convert';

import 'package:chat/model/group_model.dart';

class ResponseGroups {
  String? event;
  List<GroupModel>? listGroup;
  ResponseGroups({
    required this.event,
    required this.listGroup,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (event != null) {
      result.addAll({'event': event});
    }
    if (listGroup != null) {
      result.addAll({'listGroup': listGroup!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ResponseGroups.fromMap(Map<String, dynamic> map) {
    return ResponseGroups(
      event: map['event'],
      listGroup: map['listGroup'] != null
          ? List<GroupModel>.from(
              map['listGroup']?.map((x) => GroupModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGroups.fromJson(String source) =>
      ResponseGroups.fromMap(json.decode(source));
}
