import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gchat/src/common/authentication/model/user.model.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/cubit/chat_cubit.dart';
import 'package:gchat/src/modules/chat/enums/socket_status.enums.dart';
import 'package:gchat/src/modules/chat/repository/chat_repository.dart';
import 'package:gchat/src/modules/chat/sub-views/chatbox/views/chatbox.view.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/view/conversation_list.view.dart';
import 'package:gchat/src/modules/chat/widgets/ChatBoxUserInfoWidget.dart';
import 'package:gchat/src/modules/chat/widgets/SocketConnectionStatusWidget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.user});
  static String routeName = '/chat';
  final MUser user;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ChatRepository>(
      create: (context) {
        return ChatRepository();
      },
      child: BlocProvider<ChatCubit>(
        create: (context) {
          ChatCubit cubit = ChatCubit(
            repository: context.read<ChatRepository>(),
            playerId: user.playerId,
          );
          cubit.connect();
          return cubit;
        },
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return WillPopScope(
              child: Scaffold(
                appBar: AppBar(
                  title: state.selected != null
                      ? ChatBoxUserInfoWidget(
                          selected: state.selected!,
                          isTyping: state.isTyping,
                        )
                      : context.homeAppTitle(textA: "Ze", textB: " Chat"),
                  titleSpacing: 2,
                  actions: [
                    state.selected != null
                        ? IconButton(
                            onPressed: () {}, icon: const Icon(Icons.call))
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          ),
                    state.selected != null
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.video_call),
                          )
                        : context.logoutButton()
                  ],
                ),
                body: Column(
                  children: [
                    SocketConnectionStatusWidget(state: state),
                    Expanded(
                      child: Stack(
                        children: [
                          if (state.status.isConnected)
                            ConversationListView(
                              onSelected: (p0) => context
                                  .read<ChatCubit>()
                                  .setSelectedConversation(p0),
                              onCubitCreated: (p0) {
                                context
                                    .read<ChatCubit>()
                                    .setConversationListCubit(p0);
                              },
                            ),
                          if (state.status.isConnected &&
                              state.selected != null)
                            ChatBoxView(
                              onMessage: (data) {
                                context.read<ChatCubit>().sendMessage(data);
                              },
                              onChange: (p0) {
                                context.read<ChatCubit>().sendTypingEvent();
                              },
                              conversation: state.selected!,
                              onCreated: (p0) =>
                                  context.read<ChatCubit>().setChatBoxCubit(p0),
                            )
                        ],
                      ),
                    ),
                    if (!state.status.isConnected)
                      Expanded(
                        child: Text(state.status.name),
                      )
                  ],
                ),
              ),
              onWillPop: () {
                if (state.selected != null) {
                  context.read<ChatCubit>().setSelectedConversation(null);
                  return Future.value(false);
                } else {
                  return Future.value(true);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
