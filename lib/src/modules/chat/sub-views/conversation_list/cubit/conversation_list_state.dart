part of 'conversation_list_cubit.dart';

class ConversationListState {
  Conversation? selected;
  Map<String, String> lastMessages = {};
  Map<String, bool> isTyping = {};
  ConversationListState({
    this.selected = null,
    this.lastMessages = const {},
    this.isTyping = const {},
  });

  ConversationListState copyWith({
    Conversation? selected,
    Map<String, String>? lastMessages,
    Map<String, bool>? isTyping,
  }) {
    return ConversationListState(
      selected: selected ?? this.selected,
      lastMessages: lastMessages ?? this.lastMessages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}
