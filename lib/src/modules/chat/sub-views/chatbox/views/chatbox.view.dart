import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/cubit/chatbox_cubit.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/repository/chatbox.repository.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/widgets/ChatInputBox.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/widgets/EndDataStatusWidget.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/widgets/MessageBubbleWidget.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';

class ChatBoxView extends StatelessWidget {
  const ChatBoxView({
    super.key,
    required this.onMessage,
    required this.onChange,
    required this.conversation,
    required this.onCreated,
  });
  final Function(String) onMessage;
  final Function(String) onChange;
  final Conversation conversation;
  final Function(ChatboxCubit) onCreated;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ChatBoxRepository(context.apiService),
      child: BlocProvider<ChatboxCubit>(
        create: (context) {
          final cubit = ChatboxCubit(
            conversation: conversation,
            repository: context.read<ChatBoxRepository>(),
          );
          cubit.fetchMessages();
          return cubit;
        },
        child: _XChatBoxView(
          onChange: onChange,
          onMessage: onMessage,
          conversation: conversation,
          onCreated: onCreated,
        ),
      ),
    );
  }
}

class _XChatBoxView extends StatefulWidget {
  const _XChatBoxView({
    super.key,
    required this.onMessage,
    required this.onChange,
    required this.onCreated,
    required this.conversation,
  });
  final Function(String) onMessage;
  final Function(String) onChange;
  final Function(ChatboxCubit) onCreated;
  final Conversation conversation;

  @override
  State<_XChatBoxView> createState() => _XChatBoxViewState();
}

class _XChatBoxViewState extends State<_XChatBoxView> {
  @override
  void initState() {
    super.initState();
    widget.onCreated(context.read<ChatboxCubit>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: BlocBuilder<ChatboxCubit, ChatboxState>(
                builder: (context, state) {
                  if (state.messages.isEmpty) {
                    return const Center(
                      child: Text('No messages'),
                    );
                  } else {
                    return ListView(
                      reverse: true,
                      controller: context.read<ChatboxCubit>().scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...state.messages.values
                            .toList()
                            .map(
                              (element) => MessageBubbleWidget(
                                conversation: widget.conversation,
                                message: element,
                              ),
                            )
                            .toList(),
                        EndMessageDataStatusWidget(state: state),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          ChatInputBoxWidget(
            onMessage: widget.onMessage,
            onChange: widget.onChange,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
