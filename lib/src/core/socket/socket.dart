import 'package:flutter/material.dart';
import 'package:gchat/src/core/api/endpoints.dart';
import 'package:gchat/src/core/helpers/storage.helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// make Singleton class
class SocketService {
  bool logs = false;
  final String _TAG = 'SocketService';
  static final SocketService instance = SocketService._internal();
  SocketService._internal();

  IO.Socket socket = IO.io(
    ApiEndpoints.SOCKET_URL,
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setExtraHeaders(
          {'Authorization': StorageHelper.instance.token},
        )
        .build(),
  );

  connect() {
    if (socket.connected) {
      logPrint('existing socket status: ${socket.connected}');
      logPrint('Socket already connected. Disconnecting...');
      return;
    }
    logPrint('Connecting to socket...');

    print(StorageHelper.instance.token);
    socket.connect();
  }

  // Default socket status listners

  // onConnect(Function callback) => socket?.on('connect', (data) {
  onConnect(Function callback) => socket.onConnect(
        (data) {
          logPrint('Connected to socket');
          callback(data);
        },
      );

  // onDisconnect(Function callback) => socket?.on('disconnect', (data) {
  onDisconnect(Function callback) => socket.onDisconnect((data) {
        logPrint('Disconnected from socket');
        callback(data);
      });

  // onError(Function callback) => socket?.on('error', (data) {
  onError(Function callback) => socket.onError((data) {
        logPrint('Socket error: $data');
        callback(data);
      });

  // onReconnecting(Function callback) => socket?.on('reconnecting', (data) {
  onReconnecting(Function callback) => socket.onReconnect((data) {
        logPrint('Reconnecting to socket');
        callback(data);
      });

  // onConnectionError(Function callback) => socket?.on('connect_error', (data) {
  onConnectionError(Function callback) => socket.onConnectError((data) {
        logPrint('Connection error: $data');
        callback(data);
      });

  sendMessage(Map<String, dynamic> message) {
    socket.emit('CONVERSATION_MESSAGE', message);
  }

  listenConversation(Function(Map<String, dynamic>) callback) {
    socket.on('RECEIVE-CONVERSATION', (data) {
      callback(data);
    });
  }

  registerEvent(String event, Function(dynamic) callback) {
    socket.on(event, (data) {
      logPrint('Event: $event, Data: $data');
      callback(data);
    });
  }

  listenEvent(String event, Function(dynamic) callback) {
    socket.on(event, (data) => callback(data));
  }

  removerEvent(String event) {
    socket.off(event);
  }

  disconnect() {
    logPrint('Disconnecting from socket...');
    socket.clearListeners();
    socket.disconnect();
    logPrint('Disposing socket...');
    socket.dispose();
  }

  logPrint(String message) {
    if (logs) {
      debugPrint('[$_TAG]: $message');
    }
  }
}
