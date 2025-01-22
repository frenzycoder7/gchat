import 'package:flutter/material.dart';
import 'package:gchat/src/common/extensions/context.extension.dart';
import 'package:gchat/src/modules/chat/sub-views/conversation_list/model/conversation.model.dart';

class ChatBoxUserInfoWidget extends StatelessWidget {
  const ChatBoxUserInfoWidget(
      {super.key,
      required this.selected,
      required this.isTyping,
      required this.onBack});
  final Conversation selected;
  final bool isTyping;
  final Function() onBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        Container(
          height: 450,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  "https://getyoursquad.in/avatar/${selected.user.userImage}"),
            ),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selected.user.userName),
            if (isTyping)
              Text(
                "Typing...",
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.green.shade500,
                ),
              ),
          ],
        )
      ],
    );
  }
}
