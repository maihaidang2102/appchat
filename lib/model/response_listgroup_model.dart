import 'dart:convert';

import 'package:chat/model/group_model.dart';

class ResponseGroups {
  String event;
  List<GroupModel> listGroup;
  ResponseGroups({
    required this.event,
    required this.listGroup,
  });



  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'event': event});
    result.addAll({'listGroup': listGroup.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory ResponseGroups.fromMap(Map<String, dynamic> map) {
    return ResponseGroups(
      event: map['event'] ?? '',
      listGroup: List<GroupModel>.from(map['listGroup']?.map((x) => GroupModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseGroups.fromJson(String source) => ResponseGroups.fromMap(json.decode(source));
}
