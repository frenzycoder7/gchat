import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gchat/src/core/helpers/storage.helper.dart';
import 'package:gchat/src/core/socket/socket.dart';
import 'package:gchat/src/modules/chat/enums/socket_status.enums.dart';
import 'package:gchat/src/modules/chat/repository/chat_repository.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/cubit/chatbox_cubit.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/cubit/conversation_list_cubit.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  String _TAG = "ChatCubit";
  ChatRepository repository;
  String playerId;
  final SocketService _socket = SocketService.instance;
  Function(Map<String, dynamic>)? _onNewMessage;

  ConversationListCubit? conversationListCubit;
  ChatboxCubit? chatboxCubit;
  Timer? _typingTimer;

  ChatCubit({
    required this.repository,
    required this.playerId,
  }) : super(ChatState.connecting());

  void connect() {
    _socket.logs = true;
    if (_socket.socket.connected) {
      emit(ChatState.connected());
    } else {
      _socket.onConnect((data) => emit(ChatState.connected()));
      _socket.onDisconnect((data) => emit(ChatState.disconnected()));
      _socket.onError((data) => emit(ChatState.error(data.toString())));

      _socket.onReconnecting((data) => emit(ChatState.reconnecting()));
      _socket.onTimeout((data) => emit(ChatState.error(data.toString())));
      _socket.connect();
    }
    _listenConversationEvent();
  }

  sendTypingEvent() {
    debugPrint('$_TAG sendTypingEvent');
    if (state.selected != null) {
      Map<String, dynamic> data = {
        "activityType": "TYPING",
        "to": state.selected!.user.id,
        "from": StorageHelper.instance.user?.id,
        "convId": state.selected!.convId,
      };
      debugPrint('$_TAG sendTypingEvent: $data');
      _socket.sendMessage(data);
    }
  }

  sendMessage(String message) {
    debugPrint('$_TAG sendMessage: $message');
    if (state.selected != null) {
      Map<String, dynamic> data = {
        "activityType": "MESSAGE",
        "to": state.selected!.user.id,
        "from": StorageHelper.instance.user?.id,
        "localId": DateTime.now().millisecondsSinceEpoch.toString() +
            state.selected!.convId,
        "text": message,
      };
      debugPrint('$_TAG sendMessage: $data');
      _socket.sendMessage(data);
    }
  }

  void _listenConversationEvent() {
    _socket.listenConversation((p0) {
      if (_onNewMessage != null) {
        _onNewMessage!(p0);
      }
      final String activityType = p0['type'];
      switch (activityType) {
        case "ACK":
        case "MESSAGE":
          _newMessagehandler(p0);
          break;
        case "ERROR":
          _errorHandler(p0);
          break;
        case "TYPING":
          _typingHandler(p0);
          break;
      }
    });
  }

  void _newMessagehandler(Map<String, dynamic> data) {
    if (conversationListCubit != null) {
      conversationListCubit!.newIncomingMessageHandler(
        data['message']['convId'],
        data['message']['text'],
      );
    }
    if (chatboxCubit != null) {
      chatboxCubit!.onData(data);
    }

    if (state.selected == null) {
      // Show notification if the user is not in the chat screen
    }
  }

  void _errorHandler(Map<String, dynamic> data) {
    print("Error: $data");
  }

  void _typingHandler(Map<String, dynamic> data) {
    if (conversationListCubit != null) {
      conversationListCubit!.typingHandler(data);
    }
    if (state.selected != null) {
      var usr = state.selected!.user;
      if (usr.id == data['from']) {
        emit(ChatState.typing(true, state.selected!));
        if (_typingTimer != null) {
          _typingTimer!.cancel();
          _typingTimer = Timer(Duration(seconds: 2), () {
            emit(ChatState.typing(false, state.selected!));
          });
        } else {
          _typingTimer = Timer(Duration(seconds: 2), () {
            emit(ChatState.typing(false, state.selected!));
          });
        }
      }
    }
  }

  void setConversationListCubit(ConversationListCubit cubit) {
    conversationListCubit = cubit;
  }

  void setChatBoxCubit(ChatboxCubit cubit) {
    debugPrint('$_TAG setChatBoxCubit: $cubit');
    chatboxCubit = cubit;
  }

  void setSelectedConversation(Conversation? conversation) {
    if (_typingTimer != null) {
      _typingTimer!.cancel();
      _typingTimer = null;
    }
    emit(ChatState.selectConversation(conversation));
  }

  @override
  Future<void> close() {
    _socket.disconnect();
    return super.close();
  }
}
