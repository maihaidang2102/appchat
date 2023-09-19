// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import 'package:chat/model/message_model.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends HydratedBloc<MessageEvent, MessageState> {
  MessageBloc() : super(const MessageState(messages: [])) {
    on<AddMessage>(addMessage);
  }

  Future<FutureOr<void>> addMessage(AddMessage event, Emitter<MessageState> emit) async {
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    // final userID = prefs.getString('userID');
    //   List<MessageModel> messages = state.messages;
    //   // messages.add(MessageModel(senderInfo: userID, message: event.message, type: null, status: null, groupId: ''));
    //   emit(MessageState(messages: messages));
    // } catch (e, stackTrack) {
    //   log(stackTrack.toString());
    //   log(e.toString());
    // }
  }
  
  @override
  MessageState? fromJson(Map<String, dynamic> json) {
    return MessageState.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(MessageState state) {
    return state.toMap();
  }
}
