part of 'chatbox_cubit.dart';

class ChatboxState {
  Map<String, Message> messages = {};
  bool canFetchMore = true;
  ResponseStatus status = ResponseStatus.CALLING;
  Conversation conversation;
  String message = '';

  ChatboxState({
    this.messages = const {},
    this.canFetchMore = true,
    required this.conversation,
    this.status = ResponseStatus.CALLING,
    this.message = '',
  });

  ChatboxState copyWith({
    Map<String, Message>? messages,
    bool? canFetchMore,
    Conversation? conversation,
    ResponseStatus? status,
    String? message,
  }) {
    return ChatboxState(
      messages: messages ?? this.messages,
      canFetchMore: canFetchMore ?? this.canFetchMore,
      conversation: conversation ?? this.conversation,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
