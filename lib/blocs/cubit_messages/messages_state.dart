import 'package:chat/model/response_message.dart';


abstract class MessagesState {}

class MessageInitial extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageItem> messages;
  MessagesLoaded(this.messages);

}

class GroupCreating extends MessagesState {}


class GroupCreated extends MessagesState {
  final String groupId;

  GroupCreated(this.groupId);
}
class MessageSent extends MessagesState {}

class MessageError extends MessagesState {
  final String error;

  MessageError(this.error);
}
