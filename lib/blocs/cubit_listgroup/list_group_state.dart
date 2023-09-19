part of 'list_group_cubit.dart';

class ListGroupState extends Equatable {
  const ListGroupState({required this.listGroup});
  final List<GroupModel> listGroup;

  @override
  List<Object> get props => [listGroup];


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'listGroup': listGroup.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory ListGroupState.fromMap(Map<String, dynamic> map) {
    return ListGroupState(
      listGroup: List<GroupModel>.from(map['listGroup']?.map((x) => GroupModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListGroupState.fromJson(String source) => ListGroupState.fromMap(json.decode(source));
}
