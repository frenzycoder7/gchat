import 'dart:async';

import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gchat/src/core/api/api_response.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/repository/conversation.repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
part 'conversation_list_state.dart';

class ConversationListCubit extends Cubit<ConversationListState> {
  final String _TAG = '[cubit] - ConversationListCubit.dart:';
  final ConversationRepository _repository;

  PagingController<int, Conversation> pagingController =
      PagingController(firstPageKey: 0);

  final Map<String, Timer> _typingTimers = {};

  ConversationListCubit(ConversationRepository repository)
      : _repository = repository,
        super(ConversationListState()) {
    debugPrint('$_TAG registering page listener');
    pagingController.addPageRequestListener(fetchConversations);
  }

  void fetchConversations(int page) async {
    debugPrint('$_TAG fetching conversations for page: $page');
    try {
      Pair<ApiResponse, List<Conversation>> res =
          await _repository.fetchConversations(page);
      if (res.last.length < 10) {
        pagingController.appendLastPage(res.last);
      } else {
        pagingController.appendPage(res.last, page + 1);
      }
      pagingController.error = res.first.message;
    } catch (e) {
      debugPrint('$_TAG error fetching conversations: $e');
      pagingController.error = e.toString();
    }
  }

  void typingHandler(Map<String, dynamic> p0) {
    debugPrint('$_TAG $p0 - [typingHandler]');

    String from = p0['from'];
    Map<String, bool> isTyping = Map.from(state.isTyping);
    isTyping[from] = true;
    emit(state.copyWith(isTyping: isTyping));

    if (_typingTimers.containsKey(from)) {
      _typingTimers[from]!.cancel();
      _typingTimers.remove(from);
      updateTypingStatus(from);
    } else {
      updateTypingStatus(from);
    }
  }

  updateTypingStatus(String from) {
    _typingTimers[from] = Timer(const Duration(seconds: 2), () {
      Map<String, bool> isTyping = Map.from(state.isTyping);
      isTyping[from] = false;
      emit(state.copyWith(isTyping: isTyping));
    });
  }

  void newIncomingMessageHandler(String convId, String message) {
    debugPrint('$_TAG $message - [newIncomingMessageHandler]');
    Map<String, String> lastMessages = Map.from(state.lastMessages);
    lastMessages[convId] = message;
    emit(state.copyWith(lastMessages: lastMessages));
  }

  void setSelected(Conversation conversation) {
    debugPrint('$_TAG $conversation - [setSelected]');
    emit(state.copyWith(selected: conversation));
  }

  @override
  Future<void> close() {
    debugPrint('$_TAG closing cubit');
    pagingController.dispose();
    debugPrint('$_TAG disposed paging controller');
    return super.close();
  }
}
