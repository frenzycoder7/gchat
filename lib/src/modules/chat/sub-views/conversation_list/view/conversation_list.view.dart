import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/cubit/conversation_list_cubit.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/repository/conversation.repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class ConversationListView extends StatelessWidget {
  const ConversationListView({
    super.key,
    required this.onSelected,
    required this.onCubitCreated,
  });
  final Function(Conversation) onSelected;
  final Function(ConversationListCubit) onCubitCreated;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ConversationRepository>(
      create: (context) {
        return ConversationRepository(context.apiService);
      },
      child: BlocProvider(
        create: (context) =>
            ConversationListCubit(context.read<ConversationRepository>()),
        child: _ConversationListSubView(
            onSelected: onSelected, onCubitCreated: onCubitCreated),
      ),
    );
  }
}

class _ConversationListSubView extends StatelessWidget {
  const _ConversationListSubView({
    required this.onSelected,
    required this.onCubitCreated,
  });
  final Function(Conversation) onSelected;
  final Function(ConversationListCubit) onCubitCreated;
  @override
  Widget build(BuildContext context) {
    ConversationListCubit cubit = context.read<ConversationListCubit>();
    onCubitCreated(cubit);
    return BlocBuilder<ConversationListCubit, ConversationListState>(
      builder: (context, state) {
        return PagedListView(
          pagingController: cubit.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Conversation>(
            itemBuilder: (context, item, index) {
              bool isTyping = state.isTyping[item.user.id] ?? false;
              String? lastMessage = state.lastMessages[item.convId];
              return InkWell(
                onTap: () {
                  cubit.setSelected(item);
                  onSelected(item);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: context.theme.dividerColor,
                      ),
                    ),
                    color: state.selected != null &&
                            state.selected!.convId == item.convId
                        ? context.theme.primaryColor.withOpacity(0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          "assets/avatar/${item.user.userImage}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.user.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              isTyping
                                  ? "Typing..."
                                  : lastMessage ?? item.lastMessage.messageText,
                              style: context.theme.textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formattedDate(item.lastMessage.messageCreatedAt),
                        style: context.theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String formattedDate(String date) {
    DateFormat formatter = DateFormat('dd MMM, hh:mm a');
    return formatter.format(DateTime.parse(date));
  }
}
