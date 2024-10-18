// ignore_for_file: constant_identifier_names

enum SocketStatus {
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR,
  RECONNECTING,
  RECONNECTED,
}


extension SocketStatusExtension on SocketStatus {
  bool get isConnecting => this == SocketStatus.CONNECTING;
  bool get isConnected => this == SocketStatus.CONNECTED;
  bool get isDisconnected => this == SocketStatus.DISCONNECTED;
  bool get isError => this == SocketStatus.ERROR;
  bool get isReconnecting => this == SocketStatus.RECONNECTING;
  bool get isReconnected => this == SocketStatus.RECONNECTED;
  bool get isAnyError => isError || isDisconnected;
  bool get isSucess => isConnected || isReconnected;
}