part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState._({
    this.status = SocketStatus.CONNECTING,
    this.message,
    this.selected,
    this.isTyping = false,
  });

  Conversation? selected;
  bool isTyping;

  ChatState.unknown() : this._();
  ChatState.connecting()
      : this._(status: SocketStatus.CONNECTING, message: "Connecting...");
  ChatState.connected()
      : this._(status: SocketStatus.CONNECTED, message: "Connected");
  ChatState.disconnected()
      : this._(status: SocketStatus.DISCONNECTED, message: "Disconnected");
  ChatState.error(String message)
      : this._(status: SocketStatus.ERROR, message: message);
  ChatState.reconnecting()
      : this._(status: SocketStatus.RECONNECTING, message: "Reconnecting...");
  ChatState.reconnected()
      : this._(status: SocketStatus.RECONNECTED, message: "Reconnected");

  ChatState.selectConversation(Conversation? conversation)
      : this._(status: SocketStatus.CONNECTED, selected: conversation);
  ChatState.typing(bool isTyping, Conversation conversation)
      : this._(
            status: SocketStatus.CONNECTED,
            selected: conversation,
            isTyping: isTyping);

  SocketStatus status;
  String? message;

  @override
  List get props => [status, selected, message, isTyping];
}
