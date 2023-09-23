// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:chat/model/response_listgroup_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat/api_service/socket_manager.dart';
import 'package:chat/model/group_model.dart';

part 'list_group_state.dart';

class ListGroupCubit extends HydratedCubit<ListGroupState> {
  ListGroupCubit() : super(const ListGroupState(listGroup: [])) {
    _socketManager.addMessageListener((data) {
      try {
        if (data.toString().contains('list_group')) {
          ResponseGroups responseGroups = ResponseGroups.fromJson(data);
          log("=================================GET LIST GROUP ==================================");
          updateGroups(responseGroups.listGroup!);
        }
      } catch (e) {
        log("=================================Error GET LIST GROUP ==================================");
        updateGroups([]);
        log(e.toString());
      }
    });
  }
  final _socketManager = SocketManager.instance;
  Future<void> updateGroups(List<GroupModel> groups) async {
    if (groups.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('groupId', groups.first.id!);
    }
    emit(ListGroupState(listGroup: groups));
  }

  Future<void> getListGroup() async {
    log("=================================GET LIST GROUP START ==================================");

    try {
      final prefs = await SharedPreferences.getInstance();
      final userID = prefs.getString('userID');
      _socketManager
          .sendData(jsonEncode({"event": "list_group", "userId": userID}));
    } catch (e, stackTrack) {
      log(stackTrack.toString());
      log(e.toString());
    }
  }

  @override
  ListGroupState? fromJson(Map<String, dynamic> json) {
    return ListGroupState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListGroupState state) {
    return state.toMap();
  }
}
