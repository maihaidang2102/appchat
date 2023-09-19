part of 'message_bloc.dart';

@immutable
class MessageState extends Equatable {
  final List<MessageModel> messages;

  const MessageState({required this.messages});

  @override
  List<Object?> get props => [messages];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'messages': messages.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory MessageState.fromMap(Map<String, dynamic> map) {
    return MessageState(
      messages: List<MessageModel>.from(map['messages']?.map((x) => MessageModel.fromMap(x))),
    );
  }

}
