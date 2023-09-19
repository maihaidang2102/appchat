part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}


class AddMessage extends MessageEvent{
  final String message;

  AddMessage({required this.message});
}