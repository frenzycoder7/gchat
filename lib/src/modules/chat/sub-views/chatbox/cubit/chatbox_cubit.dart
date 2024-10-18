import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gchat/src/core/api/api.enums.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/core/api/extension.api.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/model/message.model.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/repository/chatbox.repository.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';
part 'chatbox_state.dart';

class ChatboxCubit extends Cubit<ChatboxState> {
  final String _TAG = "ChatboxCubit";
  final Conversation _conversation;
  final ChatBoxRepository _repository;
  ScrollController scrollController = ScrollController();
  int currentPage = -1;

  ChatboxCubit({
    required ChatBoxRepository repository,
    required Conversation conversation,
  })  : _repository = repository,
        _conversation = conversation,
        super(ChatboxState(conversation: conversation)) {
    regitserPagination();
  }

  void onData(Map<String, dynamic> onData) {
    debugPrint('$_TAG onData: $onData');
    String type = onData['type'];
    switch (type) {
      case 'ACK':
      // {
      // MessageAck messageAck = MessageAck.fromJSON(data);
      // if (messageAck.message == null ||
      //     conversation.convId != messageAck.message?.convId) {
      //   return;
      // }
      // Map<String, CMessage> messages = state.messages;
      // if (messageAck.message != null) {
      //   messages[messageAck.message!.localId ?? ""] = messageAck.message!;
      //   emit(state.copyWith(msg: messages));
      // }
      // }
      // break;
      case 'MESSAGE':
        {
          debugPrint('$_TAG type: MESSAGE ');
          Message message = Message.fromJSON(onData['message']);
          if (_conversation.convId != message.convId) {
            return;
          }
          Map<String, Message> messages = state.messages;
          debugPrint('$_TAG emitting message: ${message.localId}');
          emit(state
              .copyWith(messages: {message.localId: message, ...messages}));
        }
        break;

      default:
        break;
    }
  }

  regitserPagination() {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent - 50 &&
          !scrollController.position.outOfRange) {
        print("load more data");
        if (state.canFetchMore && !state.status.isCalling) {
          fetchMessages();
        }
      }
    });
  }

  fetchMessages() async {
    try {
      emit(state.copyWith(status: ResponseStatus.CALLING));
      Pair<ApiResponse, Map<String, Message>> res =
          await _repository.getMessages(_conversation.convId, currentPage + 1);
      if (res.first.isSuccessful && res.last.isNotEmpty) {
        if (res.last.length < 20) {
          emit(state.copyWith(
            canFetchMore: false,
            messages: {...state.messages, ...res.last},
            status: ResponseStatus.SUCCESS,
          ));
        } else {
          emit(state.copyWith(
            canFetchMore: true,
            messages: {...state.messages, ...res.last},
            status: ResponseStatus.SUCCESS,
          ));
          currentPage = currentPage + 1;
        }
      } else {
        emit(state.copyWith(
          canFetchMore: true,
          status: ResponseStatus.ERROR,
          message: res.first.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        canFetchMore: true,
        status: ResponseStatus.ERROR,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
